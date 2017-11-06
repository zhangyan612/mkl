import numpy as np
import wave, struct

filepath = 'clap.wav'
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
            return True
            


waveFile = wave.open(filepath, 'r')

length = waveFile.getnframes()
for i in range(0,length):
    waveData = waveFile.readframes(1)
    #data = struct.unpack("<h", waveData)
    #print(int(data[0]))
    add_data(waveData)

