# find ip
sudo ifconfig

# go to system config
sudo su
raspi-config

sudo shutdown -h now


# change password
# When logged in as the pi user, you can change your password with the  passwd command.
passwd

# install vnc
sudo apt-get update
sudo apt-get install realvnc-vnc-server realvnc-vnc-viewer

sudo raspi-config 
# Scroll down to VNC and set it to Enabled.
