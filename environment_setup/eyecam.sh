# set up microphone
sudo apt-get install python-pyaudio python3-pyaudio sox
pip install pyaudio
sudo apt-get install libatlas-base-dev

# testing recording and play
rec temp.wav
aplay /home/pi/temp.wav
# list recording device
arecord -l

# test hotword detection
python demo.py Alice.pmdl
python demo.py snowboy.umdl

# take picture
sudo apt-get install fswebcam
fswebcam image.jpg
fswebcam -r 640×480 image2.jpg

# video streaming
sudo apt-get install motion

# Edit the config file:
sudo nano /etc/motion/motion.conf

# To enable daemon mode (so you can run the software in the background without it tying up your terminal):
daemon on

#To increase the resolution to the maximum supported by the EyeToy, change the following lines:width 640
height 480

# By default, the camera will only start capturing images (and video) if it detects motion. If you want to take regular snapshots whether motion is detected or not, you can change the following line (the value is in seconds):
snapshot_interval 0

#If you want the stream to be viewable from other computers on the network (rather than just the Pi itself):
stream_localhost off

#If you want to change the port on which the stream is served (default 8080) – replace 1234 with the desired port number:
stream_port 8081

# Quality of the jpeg (in percent) images produced (default: 50)
webcam_quality 100

# Maximum framerate for webcam streams (default: 1)
webcam_maxrate 100

# Stop recording videos
ffmpeg_cap_new off

#default on (this disables storing images, since we only require video)
output_pictures off 

# run it
sudo motion -n

# browse
http://192.168.0.51:8081/

# pause motion detection
http://192.168.0.51:8081/0/detection/pause 
