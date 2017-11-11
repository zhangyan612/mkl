# system settings 
sudo visudo

# add NOPASSWD to sudo group
$yourname ALL=(ALL) NOPASSWD: ALL

# use sudo permission to open a file
sudo -i gedit /etc/odbcinst.ini
sudo -i gedit /etc/postgresql/9.3/main/pg_hba.conf
sudo -i gedit ~/.odbc.ini

# find a installed package in directory
find -iname cogutil
# list all computer packages
dpkg -l 
which -a psql
/usr/bin/psql --version

# Show all files 
ctrl + H 

# list installed 
sudo apt list --installed | less

# To remove all the contents of the folder(including all interior folders) but not the folder itself: 
rm -rf /path/to/directory/*
rm -rf /var/lib/motion/*

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

# To verify if it worked. Just type in your terminal
gcc -v

# If everything went fine you should see gcc 6.1.1 by the time I am writing this gist


# git install and setup 
git config --global user.email "zhangyan612@gmail.com"
git config --global user.name "Yan Zhang"

# add untracked files 
git add -A

# git cache current user 
# Set git to use the credential memory cache - default 15min
# git config --global credential.helper cache

# Set the cache to timeout after 1 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'

# push simple 
git config --global push.default simple

# switch github origin
git remote set-url origin https://github.com/zhangyan612/atomspace.git


# get current user name 
whoami

# grant admin to user
sudo usermod -a -G sudo yan
sudo usermod -a -G root yan
sudo adduser yan sudo
# give sudo to pi
sudo usermod -a -G sudo pi
# rename the user name and change folder 
sudo usermod -l yan chengxin

To change home-folder, use
usermod -d /home/yan -m yan

adduser yan sudo

# add no password for user
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


# change folder permission to allow everyone edit 
sudo chmod -R ugo+rw ~/repos
sudo chmod -R ugo+rw ~/catkin_ws
sudo chmod -R ugo+rw /home/yan/.ros
sudo chmod -R ugo+rw ~/opencog

# make file executible
chmod +x scriptname

# update boost to 1.60
cd /usr/local
wget https://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz/download
tar -xzvf download
rm download
cd boost_1_60_0

# clang toolset has error
#./bootstrap.sh --with-toolset=clang --with-icu --with-python=python --libdir=/usr/local/lib --includedir=/usr/local/include
#./b2 toolset=clang install

./bootstrap.sh --with-icu --with-python=python --libdir=/usr/local/lib --includedir=/usr/local/include
./b2 install

sudo -i gedit boostrap


# add or remove a ppa
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

# remove 
ls /etc/apt/sources.list.d
sudo rm -i /etc/apt/sources.list.d/boost-latest-ppa-trusty.list
# confirm by typing y

# installed boost package
libboost-atomic1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-atomic1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-chrono1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-chrono1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-date-time-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-date-time1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-date-time1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-filesystem-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-filesystem1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-filesystem1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-math-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-math1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-math1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-program-options-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-program-options1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-program-options1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-random-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-random1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-random1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-regex-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-regex1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-regex1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-serialization-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-serialization1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-serialization1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-system-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-system1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-system1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-thread-dev/trusty,now 1.54.0.1ubuntu1 amd64 [installed]
libboost-thread1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost-thread1.54.0/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]
libboost1.54-dev/trusty-updates,now 1.54.0-4ubuntu3.1 amd64 [installed,automatic]


ldconfig -p|grep libboost_regex
ldconfig -p|grep boost_regex-mt -l

g++ -v test.cpp -Lboost-lib-path -lboost_regex-gcc-mt

cat /usr/include/boost/version.hpp | grep "define BOOST_LIB_VERSION"


# change launcher location to bottom 
sudo apt-get install unity-tweak-tool
sudo apt-get install cairo-dock


# install tmux
apt get install tmux

ctrl + b # but not work

# don't do it
# remove python 3.4 first, bad idea, lots of dependencies on 3.4
# so just install 3.5 and set alias
sudo apt-get remove 'python3.*'

# install python 3.5
# sudo apt-get install build-essential checkinstall
# sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

cd /usr/src
wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
sudo tar xzf Python-3.5.2.tgz
cd Python-3.5.2
sudo ./configure
sudo make altinstall

# python3.5 -V

# set aliases
alias python3=python3.5
alias pip3=pip3.5


# fix screen resolution issue
# https://askubuntu.com/questions/73589/higher-screen-resolution-for-virtualbox
sudo apt-get install virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms
# after install, do a software update 

# backup and restore system 
https://askubuntu.com/questions/7809/how-to-back-up-my-entire-system

# install sphinxbase module dependencies
# install automake in order to generate make file
sudo apt-get install autoconf 
sudo apt-get install bison

# install sphinxbase
./autogen.sh
./configure
make
make check
make install

# install PocketSphinx
./autogen.sh
./configure
make clean all
make check
sudo make install