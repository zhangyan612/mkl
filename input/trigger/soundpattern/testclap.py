import numpy as np

prev_sample = 0

def add_data(data):
        """ audio is mono 16bit signed at 16kHz """
        audio = np.fromstring(data, 'int16')
        # alternative: np.abs(audio).sum() > thresh
        shifted = np.roll(audio, 1)
        shifted[0] = prev_sample
        val = np.max(np.abs(shifted - audio))
        if val > (65536 // 4):  # quarter max delta
            print("clap detected")
            
            
