# require ros to be installed before
# install turtlebot
sudo apt-get install ros-indigo-turtlebot ros-indigo-turtlebot-apps ros-indigo-turtlebot-interactions ros-indigo-turtlebot-simulator ros-indigo-kobuki-ftdi ros-indigo-rocon-remocon ros-indigo-rocon-qt-library ros-indigo-ar-track-alvar-msgs

# test turtlebot simulation
# hit tab twice to discover what's available   
# roslaunch turtlebot_
# roslaunch turtlebot_gazebo
roslaunch turtlebot_gazebo turtlebot_world.launch
# shift + click or middle click - 3d rotation

roslaunch turtlebot_teleop keyboard_teleop.launch

# i forward, j left, l right, k stop