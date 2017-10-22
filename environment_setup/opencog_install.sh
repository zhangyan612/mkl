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

