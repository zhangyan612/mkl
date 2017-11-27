# require ros to be installed before
# install turtlebot
sudo apt-get install ros-indigo-turtlebot ros-indigo-turtlebot-apps ros-indigo-turtlebot-interactions ros-indigo-turtlebot-simulator ros-indigo-kobuki-ftdi ros-indigo-rocon-remocon ros-indigo-rocon-qt-library ros-indigo-ar-track-alvar-msgs

# test turtlebot simulation
sudo -s
# hit tab twice to discover what's available   
# roslaunch turtlebot_
# roslaunch turtlebot_gazebo
roslaunch turtlebot_gazebo turtlebot_world.launch
# shift + click or middle click - 3d rotation

roslaunch turtlebot_teleop keyboard_teleop.launch

# i forward, j left, l right, k stop

# list out all topics
rostopic list
# find more info
rostopic info /odom


# troubleshooting
# stop all existing servers
killall -9 roscore
# kill before launch new gezebo simulator
killall -9 rosmaster
killall -9 gazebo & killall -9 gzserver  & killall -9 gzclient

# If ROS cannot find turtlebot_gazebo
rosdep update

# turtlebot navigation

git clone https://github.com/richardw05/mybot_ws.git

# add mybot to source
echo "source ~/mybot_ws/devel/setup.bash" >> ~/.bashrc
source ~/mybot_ws/devel/setup.bash

roslaunch mybot_gazebo mybot_world.launch
roslaunch mybot_description mybot_rviz.launch

# move the robot in rotation
rostopic pub /cmd_vel geometry_msgs/Twist "linear:
  x: 0.2
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.1"


# Run a node to view the camera data.
rosrun image_view image_view image:=/mybot/camera1/image_raw

# learn later
https://www.youtube.com/watch?v=NRzeQD_Etog

