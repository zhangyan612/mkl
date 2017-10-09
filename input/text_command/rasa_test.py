import os
cmd = (
    "python -m rasa_nlu.server & {option}").format(
        option='')

os.system(cmd)