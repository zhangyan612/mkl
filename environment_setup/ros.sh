# install ros indigo
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-indigo-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get install python-rosinstall

# install catkin tools
sudo apt-get install python-catkin-tools

# tutorial and setup

# Create a ROS Workspace
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
source devel/setup.bash

# Creating a catkin Package

# You should have created this in the Creating a Workspace Tutorial
cd ~/catkin_ws/src

catkin_create_pkg location_monitor std_msgs rospy roscpp

# show odom message
rosmsg show nav_msgs/Odometry

# build
catkin_make