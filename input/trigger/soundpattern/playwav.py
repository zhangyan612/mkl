#!/usr/bin/env python3
import sys
import os
sys.path.append('/home/pi/AIY-voice-kit-python/src/')
import aiy.audio

RECORD_DURATION_SECONDS = 2
temp_path = 'alice.wav'

print(os.path.realpath(os.path.join(__file__, '..')))

#input("When you're ready, press enter and tell me the 'trigger'")
#print('Recording...')
#aiy.audio.record_to_wave(temp_path, RECORD_DURATION_SECONDS)

print('Playing back recorded audio...')
aiy.audio.play_wave(temp_path)
