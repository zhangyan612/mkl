# some useful commands for opencog project

export PYTHONPATH="${PYTHONPATH}:/usr/local/share/opencog/python"
export PYTHONPATH="${PYTHONPATH}:/home/yan/repos/opencog-all/opencog/build/opencog/python"
export PYTHONPATH="${PYTHONPATH}:/home/yan/repos/opencog-all/opencog/build/opencog/cython"

# on ubuntu 16
export CONFIG_SHELL=/mmc/bin/bash


# steps to build working environment 
# 1. upgrade gcc first to ensure build
# 2. download octool and install dependencies for opencog
# 3. configure postage sql database 
/home/yan/repos/opencog-all/atomspace/opencog/persist/sql/README.md
sudo apt-get install postgresql-9.3
ALTER USER yan WITH PASSWORD 'zy90612';

cat opencog/persist/sql/multi-driver/atom.sql | psql mycogdata -U opencog_user


# start cogserver

cd ~/repos/opencog-all/opencog/build/opencog/cogserver/server
cogserver -c  my.conf


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

