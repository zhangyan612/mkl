# from pydub import AudioSegment
#
# # AudioSegment.ffmpeg = "D:\Work\projects\mkl\input/"
#
# song = AudioSegment.from_wav("D:\Work\projects\mkl\input/output_1507437621.wav")
# song.export("testme.flac", format="flac")


import ffmpy
ff = ffmpy.FFmpeg(executable='D:\Software/ffmpeg/bin/ffmpeg.exe',
    inputs={'output_1507437621.wav': None},
    outputs={'output.flac': None}
)
ff.run()
