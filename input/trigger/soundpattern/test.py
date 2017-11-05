from scipy.io.wavfile import read
fs, data = read('knock.wav')
# we will use the size of the array
# to determine the duration of the sound
data_size = len(data)
