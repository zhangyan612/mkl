sudo -s
apt-get update
apt install git

# change no lock settings in system tray

# make repos 
mkdir repos
cd repos

# download github source code
wget http://raw.github.com/opencog/ocpkg/master/ocpkg -O octool && chmod +rx octool && ./octool -h

mkdir opencog-all
cd opencog-all
git clone https://github.com/opencog/opencog.git
git clone https://github.com/opencog/atomspace.git
git clone https://github.com/opencog/moses.git
git clone https://github.com/opencog/link-grammar.git
git clone https://github.com/opencog/cogutil.git


# update gcc to latest version 
sudo apt-get update && \
sudo apt-get install build-essential software-properties-common -y && \
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
sudo apt-get update && \
sudo apt-get install gcc-snapshot -y && \
sudo apt-get update && \
sudo apt-get install gcc-6 g++-6 -y && \
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
sudo apt-get install gcc-4.8 g++-4.8 -y && \
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8;

gcc -v

# add git ppa and update git to latest version
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

# git install and setup 
git config --global user.email "zhangyan612@gmail.com"
git config --global user.name "Yan Zhang"

# config push behavior
git config --global push.default simple

# Set the cache to timeout after 1 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'

# try install head
cd ..
curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash

hr init Robotics

hr install head

# still got error