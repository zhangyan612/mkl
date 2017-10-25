# install instruction for roboschool on linux terminal
# have to install python 3.5
# if have 3.4, you need to uninstall it 
cd ~/repos

git clone https://github.com/openai/roboschool.git

ROBOSCHOOL_PATH=~/repos/roboschool

# if on python 3.5 environmnet
sudo apt install cmake ffmpeg pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libpython3.5-dev libboost-python-dev libtinyxml-dev
sudo apt install cmake pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libpython3.5-dev libboost-python-dev libtinyxml-dev

# otherwise some module won't work
sudo apt-get install pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libboost-python-dev libtinyxml-dev

# install fmpeg if there is error
sudo add-apt-repository ppa:mc3man/trusty-media
sudo apt-get update
sudo apt-get install ffmpeg gstreamer0.10-ffmpeg

# try to install
# Upgrade to python 3.5
# https://tecadmin.net/install-python-3-5-on-ubuntu/

pip3 install --upgrade pip
pip3 install

libpython3.5-dev 
pip3 install packagename=version --allow-unverified libpython3.5-dev
pip3.5 install libpython3.5-dev


# install bullet3 
git clone https://github.com/olegklimov/bullet3 -b roboschool_self_collision
mkdir bullet3/build
cd    bullet3/build
cmake -DBUILD_SHARED_LIBS=ON -DUSE_DOUBLE_PRECISION=1 -DCMAKE_INSTALL_PREFIX:PATH=$ROBOSCHOOL_PATH/roboschool/cpp-household/bullet_local_install -DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_EXTRAS=OFF  -DBUILD_UNIT_TESTS=OFF -DBUILD_CLSOCKET=OFF -DBUILD_ENET=OFF -DBUILD_OPENGL3_DEMOS=OFF ..
make -j4
make install
cd ../..

# sudo -H pip3 install -e $ROBOSCHOOL_PATH
pip3 install -e $ROBOSCHOOL_PATH

python3 agent_zoo/RoboschoolHumanoidFlagrun_v0_2017may.py
python3 agent_zoo/demo_race2.py




apt install qtdeclarative5-dev

sudo apt-get install qtscript5-dev


qtchooser -print-env
# qtchooser will look at the default.conf, you can create a symlink 
ln -s /usr/lib/x86_64-linux-gnu/qtchooser/qt5.conf /usr/lib/x86_64-linux-gnu/qtchooser/default.conf





# correct way to install ffmpeg
cd ~/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$PATH:$HOME/bin" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" \
  --extra-libs="-ldl" \
  --enable-gpl \
  --enable-libfreetype \
  --disable-x86asm

#   --enable-libtheora \
#   --enable-libvorbis \
#   --enable-libvpx \
#   --enable-libx264 \
#   --enable-nonfree \
#   --enable-libopus \
#   --enable-libmp3lame \
#   --enable-libfdk-aac \
#   --enable-libass \
#   --enable-x11grab

PATH="$PATH:$HOME/bin" make
make install
make distclean
hash -r
