# https://github.com/Microsoft/CNTK/blob/master/Tutorials/CNTK_202_Language_Understanding.ipynb
# import spacy
# nlp = spacy.load('en_default')
# doc = nlp(u'This is a sentence.')
from __future__ import print_function # Use a function definition from future version (say 3.x from 2.7 interpreter)
import requests
import os

# download data
#
# def download(url, filename):
#     """ utility function to download a file """
#     response = requests.get(url, stream=True)
#     with open(filename, "wb") as handle:
#         for data in response.iter_content():
#             handle.write(data)
#
# locations = ['Tutorials/SLUHandsOn', 'Examples/LanguageUnderstanding/ATIS/BrainScript']
#

data = {
  'train': { 'file': 'atis.train.ctf', 'location': 0 },
  'test': { 'file': 'atis.test.ctf', 'location': 0 },
  'query': { 'file': 'query.wl', 'location': 1 },
  'slots': { 'file': 'slots.wl', 'location': 1 },
  'intent': { 'file': 'intent.wl', 'location': 1 }
}

#
# for item in data.values():
#     location = locations[item['location']]
#     path = os.path.join('..', location, item['file'])
#     if os.path.exists(path):
#         print("Reusing locally cached:", item['file'])
#         # Update path
#         item['file'] = path
#     elif os.path.exists(item['file']):
#         print("Reusing locally cached:", item['file'])
#     else:
#         print("Starting download:", item['file'])
#         url = "https://github.com/Microsoft/CNTK/blob/release/2.2/%s/%s?raw=true"%(location, item['file'])
#         download(url, item['file'])
#         print("Download completed")
#


import math
import numpy as np

import cntk as C
import cntk.tests.test_utils
cntk.tests.test_utils.set_device_from_pytest_env() # (only needed for our build system)
C.cntk_py.set_fixed_random_seed(1) # fix a random seed for CNTK components

# number of words in vocab, slot labels, and intent labels
vocab_size = 943 ; num_labels = 129 ; num_intents = 26

# model dimensions
input_dim  = vocab_size
label_dim  = num_labels
emb_dim    = 150
hidden_dim = 300

# Create the containers for input feature (x) and the label (y)
x = C.sequence.input_variable(vocab_size)
y = C.sequence.input_variable(num_labels)

def create_model():
    with C.layers.default_options(initial_state=0.1):
        return C.layers.Sequential([
            C.layers.Embedding(emb_dim, name='embed'),
            C.layers.Recurrence(C.layers.LSTM(hidden_dim), go_backwards=False),
            C.layers.Dense(num_labels, name='classify')
        ])

# peek
z = create_model()
print(z.embed.E.shape)
print(z.classify.b.value)

# Pass an input and check the dimension
z = create_model()
print(z(x).embed.E.shape)


# Data Reading

def create_reader(path, is_training):
    return C.io.MinibatchSource(C.io.CTFDeserializer(path, C.io.StreamDefs(
         query         = C.io.StreamDef(field='S0', shape=vocab_size,  is_sparse=True),
         intent        = C.io.StreamDef(field='S1', shape=num_intents, is_sparse=True),
         slot_labels   = C.io.StreamDef(field='S2', shape=num_labels,  is_sparse=True)
     )), randomize=is_training, max_sweeps = C.io.INFINITELY_REPEAT if is_training else 1)

# peek
reader = create_reader(data['train']['file'], is_training=True)
reader.streams.keys()


def create_criterion_function(model):
    labels = C.placeholder(name='labels')
    ce   = C.cross_entropy_with_softmax(model, labels)
    errs = C.classification_error      (model, labels)
    return C.combine ([ce, errs]) # (features, labels) -> (loss, metric)

criterion = create_criterion_function(create_model())
criterion.replace_placeholders({criterion.placeholders[0]: C.sequence.input_variable(num_labels)})


def create_criterion_function_preferred(model, labels):
    ce   = C.cross_entropy_with_softmax(model, labels)
    errs = C.classification_error      (model, labels)
    return ce, errs # (model, labels) -> (loss, error metric)


def train(reader, model_func, max_epochs=10, task='slot_tagging'):
    # Instantiate the model function; x is the input (feature) variable
    model = model_func(x)

    # Instantiate the loss and error function
    loss, label_error = create_criterion_function_preferred(model, y)

    # training config
    epoch_size = 18000  # 18000 samples is half the dataset size
    minibatch_size = 70

    # LR schedule over epochs
    # In CNTK, an epoch is how often we get out of the minibatch loop to
    # do other stuff (e.g. checkpointing, adjust learning rate, etc.)
    lr_per_sample = [3e-4] * 4 + [1.5e-4]
    lr_per_minibatch = [lr * minibatch_size for lr in lr_per_sample]
    lr_schedule = C.learning_rate_schedule(lr_per_minibatch, C.UnitType.minibatch, epoch_size)

    # Momentum schedule
    momentum_as_time_constant = C.momentum_as_time_constant_schedule(700)

    # We use a the Adam optimizer which is known to work well on this dataset
    # Feel free to try other optimizers from
    # https://www.cntk.ai/pythondocs/cntk.learner.html#module-cntk.learner
    learner = C.adam(parameters=model.parameters,
                     lr=lr_schedule,
                     momentum=momentum_as_time_constant,
                     gradient_clipping_threshold_per_sample=15,
                     gradient_clipping_with_truncation=True)

    # Setup the progress updater
    progress_printer = C.logging.ProgressPrinter(tag='Training', num_epochs=max_epochs)

    # Uncomment below for more detailed logging
    # progress_printer = ProgressPrinter(freq=100, first=10, tag='Training', num_epochs=max_epochs)

    # Instantiate the trainer
    trainer = C.Trainer(model, (loss, label_error), learner, progress_printer)

    # process minibatches and perform model training
    C.logging.log_number_of_parameters(model)

    # Assign the data fields to be read from the input
    if task == 'slot_tagging':
        data_map = {x: reader.streams.query, y: reader.streams.slot_labels}
    else:
        data_map = {x: reader.streams.query, y: reader.streams.intent}

    t = 0
    for epoch in range(max_epochs):  # loop over epochs
        epoch_end = (epoch + 1) * epoch_size
        while t < epoch_end:  # loop over minibatches on the epoch
            data = reader.next_minibatch(minibatch_size, input_map=data_map)  # fetch minibatch
            trainer.train_minibatch(data)  # update model with it
            t += data[y].num_samples  # samples so far
        trainer.summarize_training_progress()


def do_train():
    global z
    z = create_model()
    reader = create_reader(data['train']['file'], is_training=True)
    train(reader, z)

do_train()
