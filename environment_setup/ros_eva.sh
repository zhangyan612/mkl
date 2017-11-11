sudo -s
apt-get upgrade

apt-get install ros-indigo-tf ros-indigo-driver-common \
 ros-indigo-cv-bridge ros-indigo-image-transport \
 ros-indigo-openni-camera ros-indigo-mjpeg-server \
 ros-indigo-usb-cam \
 ros-indigo-dynamixel-msgs \
 ros-indigo-robot-state-publisher \
 ros-indigo-joint-state-publisher

 cd ~/catkin_ws/src

git clone https://github.com/hansonrobotics/pi_vision.git
git clone https://github.com/hansonrobotics/perception.git
git clone https://github.com/hansonrobotics/blender_api_msgs.git
git clone https://github.com/hansonrobotics/blender_api.git

# The pau2motors package defines the PAU messages, which are
# needed by the perception (vision-geometry) module.
git clone https://github.com/hansonrobotics/pau2motors.git
git clone https://github.com/hansonrobotics/robots_config.git


cd ~/opencog && git clone https://github.com/opencog/ros-behavior-scripting.git


git clone https://github.com/opencog/opencog.git
git clone https://github.com/opencog/atomspace.git
git clone https://github.com/opencog/moses.git
git clone https://github.com/opencog/link-grammar.git
git clone https://github.com/opencog/relex.git
git clone https://github.com/opencog/cogutil.git

# Git pull for all OpenCog packages
find . -maxdepth 1 -mindepth 1 -type d \
   -execdir git --git-dir=$PWD/{}/.git --work-tree=$PWD/{} pull \;

# Make sure we really have the lastest chatbot scripts

cd /opencog/opencog/build; cmake ..; make install