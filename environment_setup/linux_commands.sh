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
dpkg -l 
which -a psql
/usr/bin/psql --version

# Show all files 
ctrl + H 

# list installed 
sudo apt list --installed | less


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

# git cache current user 
# Set git to use the credential memory cache - default 15min
# git config --global credential.helper cache

# Set the cache to timeout after 1 hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'

# get current user name 
whoami

# grant admin to user
sudo usermod -a -G sudo yan
sudo usermod -a -G root yan

# rename the user name and change folder 
sudo usermod -l yan chengxin

To change home-folder, use
usermod -d /home/yan -m yan



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
