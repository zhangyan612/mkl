# documentation
https://01.org/developerjourney/recipe/intel-realsense-robotic-development-kit

## system upgrade
sudo apt update
sudo apt -y dist-upgrade

## Install the linux-upboard kernel
sudo add-apt-repository ppa:ubilinux/up
sudo apt update
sudo apt -y install linux-upboard
sudo apt -y autoremove --purge 'linux-.*generic'
sudo apt autoremove --purge
### if on linux 14.04
sudo apt-get autoremove --purge 'linux-.*generic'

sudo reboot

# Verify you are running the linux-upboard kernel:
uname -r
If the output indicates you are running a kernel with the string upboard in the name, you are ready to go!:
robot@robot:~$ uname -r
4.4.0.1-upboard

# Provide kernel source access while installing the latest RealSense patches 
wget -q -O - https://bit.ly/en_krnl_src | sudo /bin/bash

# Install ROS Kinetic Kame framework 
sudo add-apt-repository http://packages.ros.org/ros/ubuntu
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net \
     --recv-key 0xB01FA116
sudo apt update

# Install ROS packages and update
sudo apt -y install ros-kinetic-desktop-full python-rosinstall ros-kinetic-realsense-camera
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo reboot


# Running the Intel RealSense R200 nodelet 
roscore &
roscd realsense_camera
roslaunch realsense_camera r200_nodelet_default.launch &
rosrun tf static_transform_publisher 0.0 0.0 0.0 0.0 0.0 0.0 \
       map camera_link 100 &

# verify camera detected
ls /dev/video*

lsmod | grep -q uvcvideo && echo "Kernel module found."

# Running RViz 

rosrun rviz rviz -d $(rospack find realsense_camera)/rviz/realsenseRvizConfiguration1.rviz

# install realsense sdk

# Add Intel server to the list of repositories :
echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main' | sudo tee /etc/apt/sources.list.d/realsense-public.list

# Register the server's public key :
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 7DCC6F0F

# Refresh the list of repositories and packages available :
sudo apt-get update

# In order to run demos install:
sudo apt-get install realsense-uvcvideo
sudo apt-get install librealsense2-utils
Reconnect the Intel RealSense depth camera and run: realsense-viewer


# Developers shall install additional packages:
sudo apt-get install librealsense2-dev
sudo apt-get install librealsense2-dbg
With dev package installed, you can compile an application with librealsense using g++ -std=c++11 filename.cpp -lrealsense2 or an IDE of your choice.

# Complete the installation by performing
reboot
to reload the kernel with modules provided by DKMS.

# Verify that the kernel is updated :
modinfo uvcvideo | grep "version:" should include realsense string

