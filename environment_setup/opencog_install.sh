# some useful commands and setups for opencog project
# on ubuntu 16
# export CONFIG_SHELL=/mmc/bin/bash

# setup for atomspace sql persistance
# steps to build working environment 
# 1. upgrade gcc first to ensure build
# 2. download octool and install dependencies for opencog
# 3. configure postage sql database 

# Instructions: /home/yan/repos/opencog-all/atomspace/opencog/persist/sql/README.md
sudo apt-get install postgresql-9.3

# edit postgresql config
# sudo vi /etc/odbcinst.ini
sudo -i gedit /etc/odbcinst.ini

sudo su - postgres
psql template1
CREATE ROLE root WITH SUPERUSER;
ALTER ROLE root WITH LOGIN;
CREATE ROLE yan WITH SUPERUSER;
ALTER ROLE yan WITH LOGIN;

ALTER USER root WITH PASSWORD 'zy90612';
ALTER USER yan WITH PASSWORD 'zy90612';

# verify role created and exit
\dg
ctrl+z
exit 
exit
createdb mycogdata
psql mycogdata
psql -c "CREATE USER opencog_user WITH PASSWORD 'cheese'" -d mycogdata

# fix peer authentication by change config file
sudo -i gedit /etc/postgresql/9.3/main/pg_hba.conf
# find local   all    all   peer and change to local   all     all    md5
service postgresql reload

# table initilization 
cd ~/repos/opencog-all/atomspace


cat opencog/persist/sql/multi-driver/atom.sql | psql mycogdata
# enter your user password

# verify table created 
psql mycogdata
\d
# try insertion
INSERT INTO TypeCodes (type, typename) VALUES (97, 'SemanticRelationNode');


# setup opencog on cogserver
# edit settings
sudo -i gedit ~/repos/opencog-all/opencog/build/lib/opencog.conf

# add following storage settings
# sql storage
STORAGE               = "mycogdata"
STORAGE_USERNAME      = "opencog_user"
STORAGE_PASSWD        = "cheese"

# copy lib/opencog.conf to your build directory (needed for production)
cp ~/repos/opencog-all/opencog/build/lib/opencog.conf ~/repos/opencog-all/opencog/build/opencog/cogserver/server/my.conf

# start cogserver
cd ~/repos/opencog-all/opencog/build/opencog/cogserver/server
cogserver -c  my.conf
# server will be running 

# start new terminal 
telnet localhost 17001
# does not work
sql-store
exit 

# guile access sql
# make sure to have root permission 
guile
(use-modules (opencog))
(use-modules (opencog persist) (opencog persist-sql))
# does not work
(sql-open "postgres:///mycogdata?user=opencog_user&password=cheese")


# test opencog rest api 
# check whether bashrc file exist 
cd ~
ls -a ~
# add following line on the bottom of bashrc file
export PYTHONPATH="${PYTHONPATH}:/usr/local/share/opencog/python"
export PYTHONPATH="${PYTHONPATH}:~/repos/opencog-all/opencog/build/opencog/python"
export PYTHONPATH="${PYTHONPATH}:~/repos/opencog-all/opencog/build/opencog/cython"
# then source it to update
source .bashrc

cd ~/repos/opencog-all/opencog/examples/restapi
python start_restapi.py

# test client connection (start new terminal)
python exampleclient.py


# importing external knowledge to atomspace 
cd ~/repos/opencog-all
git clone https://github.com/opencog/test-datasets.git

# test out ConceptNet Converter 
cd ~/repos/opencog-all/opencog/opencog/python/conceptnet
python converter.py

# enter csv, corps location
/home/yan/repos/opencog-all/test-datasets/conceptnet/conceptnet4.csv
/home/yan/repos/opencog-all/test-datasets/conceptnet/60000_Word_Freqs.csv
# output py and name it result.py

# add a new python file named load.py and load it to atomspace
# from opencog.atomspace import AtomSpace, types
# import result
# a = AtomSpace()
# result.load_concept_net(a, types)

python load.py


# install relex 

# opennlp is an optional dependency and can be installed by running the following steps after downloading it from http://sourceforge.net/projects/opennlp/
# OpenNLP - Never changes, so do this first.
wget http://www-us.apache.org/dist/opennlp/opennlp-1.5.3/apache-opennlp-1.5.3-bin.tar.gz apache-opennlp-1.5.3-bin.tar.gz
tar -zxf apache-opennlp-1.5.3-bin.tar.gz ;\
    cd apache-opennlp-1.5.3; \
    cp lib/*.jar /usr/local/share/java/; \
    cp lib/*.jar /usr/share/java/; \
    cp lib/opennlp-tools-1.5.3.jar /usr/local/share/java/opennlp-tools-1.5.0.jar; \
    cd .. ; rm -rf apache-opennlp*


# Link Parser -- changes often
# Download the current released version of link-grammar.
# The wget gets the latest version w/ wildcard
# wget -r --no-parent -nH --cut-dirs=2 http://www.abisource.com/downloads/link-grammar/current/
# tar -zxf current/link-grammar-5*.tar.gz ;\
#     cd link-grammar-5.*/; ./configure; make -j6; sudo make install; \
#     ldconfig; cd .. ; rm -rf * link-grammar*


# opencog initial installation will get it installed, so don't worry about following
# install dependencies 
cd repos/opencog-all/relex
cd install-scripts
./install-ubuntu-dependencies.sh


# opennlp is an optional dependency and can be installed by running the following steps after downloading it from http://sourceforge.net/projects/opennlp/
# wget http://www-us.apache.org/dist/opennlp/opennlp-1.5.3/apache-opennlp-1.5.3-bin.tar.gz apache-opennlp-1.5.3-bin.tar.gz
# tar -xvf opennlp-tools-1.5.0.tgz
# cd opennlp-tools-1.5.0
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
# ./build.sh
# sudo cp output/opennlp-tools-1.5.0.jar /usr/local/share/java/
# sudo cp lib/maxent-2.5.2.jar /usr/local/share/java/
# sudo cp lib/trove.jar /usr/local/share/java/

# To build relex run
ant

# Run relex
# The full set of options available for running can be found at README.md#using-relex. But, for testing run
./relation-extractor.sh


# Running Relex2Logic with OpenCog
# start relex server
# go to relex root and run 
./opencog-server.sh

# test whether it works, open a new terminal
telnet localhost 4444
this is a test.

# connect to cogserver
rlwrap telnet localhost 17001
# enter scheme shell
scm

# parse sentense 
(use-modules (opencog) (opencog nlp) (opencog nlp chatbot) (opencog nlp relex2logic))

(nlp-parse "this is a test sentence")
# returns 
# ((SentenceNode "sentence@b8bc70dd-8688-45cb-9846-c3987aad38c0"))
# Analyze the output
# u can get the first ParseNode associated with a SentenceNode
(car (sentence-get-parses (SentenceNode "sentence@b8bc70dd-8688-45cb-9846-c3987aad38c0")))
(parse-get-r2l-outputs (ParseNode "sentence@b8bc70dd-8688-45cb-9846-c3987aad38c0_parse_0" (stv 1 0.991)))

# link grammar
sudo ./configure

# download latest zipped file 

./configure
make
make check
# if check has error about locales, do following, still won't work
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure locales

make install
ldconfig

# check whether installed
make installcheck


# install hr tools to run robot 
sudo apt install curl

curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash

# add workspace
hr init robotics

# need a large space
hr install head

hr run <robot>



# Moses

cd ~/repos/opencog-all/moses
# build moses have error

apt-get -y install r-base

# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::get_default_error_string(boost::regex_constants::error_type)'
# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::cpp_regex_traits_implementation<char>::transform_primary(char const*, char const*) const'
# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::perl_matcher<__gnu_cxx::__normal_iterator<char const*, std::string>, std::allocator<boost::sub_match<__gnu_cxx::__normal_iterator<char const*, std::string> > >, boost::regex_traits<char, boost::cpp_regex_traits<char> > >::construct_init(boost::basic_regex<char, boost::regex_traits<char, boost::cpp_regex_traits<char> > > const&, boost::regex_constants::_match_flags)'
# ../libcomboreduct.so: undefined reference to `boost::match_results<__gnu_cxx::__normal_iterator<char const*, std::string>, std::allocator<boost::sub_match<__gnu_cxx::__normal_iterator<char const*, std::string> > > >::maybe_assign(boost::match_results<__gnu_cxx::__normal_iterator<char const*, std::string>, std::allocator<boost::sub_match<__gnu_cxx::__normal_iterator<char const*, std::string> > > > const&)'
# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::get_mem_block()'
# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::raise_runtime_error(std::runtime_error const&)'
# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::put_mem_block(void*)'
# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::verify_options(unsigned int, boost::regex_constants::_match_flags)'
# ../libcomboreduct.so: undefined reference to `boost::basic_regex<char, boost::regex_traits<char, boost::cpp_regex_traits<char> > >::do_assign(char const*, char const*, unsigned int)'
# ../libcomboreduct.so: undefined reference to `boost::re_detail_106000::cpp_regex_traits_implementation<char>::transform(char const*, char const*) const'
# collect2: error: ld returned 1 exit status
# make[2]: *** [moses/comboreduct/main/action-reductor] Error 1
# make[1]: *** [moses/comboreduct/main/CMakeFiles/action-reductor.dir/all] Error 2
# make: *** [all] Error 2


# It is solved by just adding the -lboost_regex to the compiling line so:

-lboost_regex

This works: $ g++ main.cc -o main -lboost_regex

make -L /usr/lib64 -l boost_regex-mt

make boost_regex-mt 

-L /usr/lib64


# run moses 
# change to super user
sudo -s
cd ~/repos/opencog-all/moses/build/moses/moses/main/
# And then you can run the MOSES program as follows
~/repos/mkl/test/robotics/moses.txt

./moses -i ~/repos/mkl/test/robotics/moses.txt -m43 -W1 # (or try dropping the ./ ./moses -i inout.txt -m43 -W1) 
# -i is used to supply an input file, which is the parameter after that.
# -m43 tells it to stop after 43 fitness function evaluations. For now think of it as the number of programs it tries to 'score', based on the distance between their desired output (the first column in our file, the target feature) and their actual output (the output generated by that version of the COMBO program MOSES has evolved).
# 43 turns out to be the minimum number to reach a program with a perfect score. Feel free to decrease the number, which will give you programs that approximate the target feature less well, or increase the number, which makes the program run longer with the same result.
# -W1 tells it to use the column labels we provided in the output programs, so we can understand them better. 



# Running Relex2Logic

# install ros related catkin
# dependencies
sudo apt-get install cmake python-catkin-pkg python-empy python-nose libgtest-dev

sudo pip install -U catkin_pkg

# not working
sudo apt-get install ros-groovy-catkin
sudo apt-get install ros-hydro-catkin


# install ros
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-lunar-desktop-full


source /opt/ros/lunar/setup.bash


# install tools
apt-get -y install \
            git-gui \
            meld \
            qtcreator

# Workspace configuration
COPY qtcreator-startup-script.sh /home/opencog/
RUN chown opencog:opencog /home/opencog/qtcreator-startup-script.sh
USER opencog
CMD /home/opencog/qtcreator-startup-script.sh


# install Ros indigo opencog eva
apt-get install byobu


# eva-opencog

# installation
cd ~/catkin_ws/src

git clone https://github.com/hansonrobotics/pi_vision.git
git clone https://github.com/hansonrobotics/perception.git
git clone https://github.com/hansonrobotics/blender_api_msgs.git
git clone https://github.com/hansonrobotics/blender_api.git
git clone https://github.com/hansonrobotics/pau2motors.git
git clone https://github.com/hansonrobotics/robots_config.git

cd ~/opencog && git clone https://github.com/opencog/ros-behavior-scripting.git

# update all package
cd ~/opencog/ && find . -maxdepth 1 -mindepth 1 -type d \
   -execdir git --git-dir=$PWD/{}/.git --work-tree=$PWD/{} pull \;

# build behavior scripting 
cd ~/opencog/ros-behavior-scripting

bash scripts/setup.sh
bash scripts/install.sh

# bash scripts/run.sh eva

# Pre-compile the guile modules.
guile
(use-modules (opencog eva-model))
(use-modules (opencog eva-behvaior))

# RUN (bash -l -c "echo \"(use-modules (opencog eva-model))\" | guile ")
# RUN (bash -l -c "echo \"(use-modules (opencog eva-behvaior))\" | guile ")

# Git pull for all ROS packages
cd ~/catkin_ws/src/

find . -maxdepth 1 -mindepth 1 -type d \
	-execdir git --git-dir=$PWD/{}/.git --work-tree=$PWD/{} pull \;

# The blender API has not been fully catkinized yet.
pip3 install ./blender_api_msgs/

cd ~/catkin_ws
/opt/ros/indigo/bin/catkin_make
make install

echo source ~/catkin_ws/devel/setup.bash >> ~/.bashrc
source ~/catkin_ws/devel/setup.bash >> ~/.bashrc
# copy modified eva.sh to catkin root
# cp /scripts/eva.sh /catkin_ws/eva.sh
cp ~/repos/mkl/environment_setup/eva.sh ~/catkin_ws/eva.sh


# mkdir ~/opencog/ros-behavior-scripting/build
# cd ~/opencog/ros-behavior-scripting/build

# running

# 1. start roscore
roscore
# byobu new-session -d -n 'ros' 'roscore; $SHELL'

# # Run the relex parse server.
# cd ~/opencog/relex && ./opencog-server.sh

# 2. Run the relex parse server. work
tmux new-window -n 'rlx' 'cd ~/opencog/relex && ./opencog-server.sh ; $SHELL'

# 3. Single Video (body) camera and face tracker. work
roslaunch perception tracker-single-cam.launch
# tmux new-window -n 'trk' 'cd ~/catkin_ws/src/perception/launch && roslaunch tracker-single-cam.launch; $SHELL'

# 4. Publish the geometry messages. This includes tf2 which holds
# the face locations. 
# roslaunch perception geometry.launch
# copy description.urdf to launch folder
cd ~/catkin_ws/src/perception/launch
roslaunch perception geometry.launch model:=description.urdf
# tmux new-window -n 'geo' 'cd ~/catkin_ws/src/perception/launch && roslaunch geometry.launch gui:=false; $SHELL'

# 5. Start the blender GUI. work
tmux new-window -n 'eva' 'cd ~/catkin_ws/src/blender_api && blender -y Sophia.blend -P autostart.py; $SHELL'

# 6. Start the IRC chatbot bridge.
tmux new-window -n 'irc' 'cd ~/opencog/opencog/build/opencog/nlp/irc && ./cogita -n ieva -f "Robot Eva" -t 17020; ; $SHELL'

# 7. Start the cogserver. 
# start form build directory btree have some issue
cp ~/opencog/opencog/build/lib/opencog.conf ~/opencog/opencog/build/opencog/cogserver/server/my.conf
cd ~/opencog/opencog/build/opencog/cogserver/server && cogserver -c  my.conf

# start from scm file
# cp ~/opencog/opencog/build/lib/opencog.conf ~/opencog/opencog/opencog/eva/scripts
# It seems to take more than 5 seconds to load all scripts!?
# error  no code for module (opencog nlp chatbot)
tmux new-window -n 'cog' 'cd ~/opencog/opencog/opencog/eva/src && guile -l btree-eva.scm ; $SHELL'

# 8. Run the new face tracker. sending data to cogserver
tmux new-window -n 'fac' 'cd ~/opencog/ros-behavior-scripting/sensors && ./main.py ; $SHELL'


# # start opencog cogita service chatbot 
# cd ~/opencog/opencog/build/opencog/nlp/irc 
# ./cogita -n ieva -f "Robot Eva" -t 17020
