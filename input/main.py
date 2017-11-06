import logging
import os
import os.path
import sys
import threading
import time
import trigger.custom
sys.path.append('/home/pi/AIY-voice-kit-python/src/')
import aiy.audio


class SyncMicRecognizer(object):
    def __init__(self, triggerer):
        self.triggerer = triggerer
        #self.triggerer.set_callback(self.recognize)
        self.running = False

    def __enter__(self):
        self.running = True
        self.triggerer.start()


recorder = aiy.audio.get_recorder()

triggerer = trigger.custom.CustomTrigger(recorder)
msg = 'Clap your hands'

mic_recognizer = SyncMicRecognizer(triggerer)

with mic_recognizer:
    if sys.stdout.isatty():
        print(msg + ' then speak, or press Ctrl+C to quit...')
    # wait for KeyboardInterrupt
    while True:
        time.sleep(1)
