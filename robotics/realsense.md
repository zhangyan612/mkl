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
rosrun tf static_transform_publisher 0.0 0.0 0.0 0.0 0.0 0.0 map camera_link 100 &

# verify camera detected
ls /dev/video*

lsmod | grep -q uvcvideo && echo "Kernel module found."

# Running RViz 

rosrun rviz rviz -d $(rospack find realsense_camera)/rviz/realsenseRvizConfiguration1.rviz

# newer sdk version
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
# Reconnect the Intel RealSense depth camera and run: 
realsense-viewer


# Developers shall install additional packages:
sudo apt-get install librealsense2-dev
sudo apt-get install librealsense2-dbg
With dev package installed, you can compile an application with librealsense using g++ -std=c++11 filename.cpp -lrealsense2 or an IDE of your choice.

# Complete the installation by performing
reboot
to reload the kernel with modules provided by DKMS.

# Verify that the kernel is updated :
modinfo uvcvideo | grep "version:" should include realsense string

# test to debug
chmod 666 /dev/media0
chmod 666 /dev/media1
chmod 666 /dev/media2
chmod 666 /dev/video0
chmod 666 /dev/video1
chmod 666 /dev/video2


# older version of sdk for R200 camera
git clone https://github.com/IntelRealSense/librealsense.git
git checkout tags/v1.12.1
cd librealsense

# Ensure apt-get is up to date
sudo apt-get update && sudo apt-get upgrade

# Install libusb-1.0 and pkg-config via apt-get
sudo apt-get install libusb-1.0-0-dev pkg-config

# For 16.04 you can install glfw3 via 
sudo apt-get install libglfw3-dev

# install QtCreator
sudo apt-get install qtcreator
sudo scripts/install_qt.sh (we also need qmake from the full qt5 distribution)

# build the librealsense project 
mkdir build
cd build
cmake ..
make && sudo make install

# Video4Linux backend
# Ensure no cameras are presently plugged into the system.
Install udev rules

sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger

./scripts/patch-uvcvideo-16.04.simple.sh

# Reload the uvcvideo driver
sudo modprobe uvcvideo

# Check installation by examining the last 50 lines of the dmesg log:
sudo dmesg | tail -n 50

