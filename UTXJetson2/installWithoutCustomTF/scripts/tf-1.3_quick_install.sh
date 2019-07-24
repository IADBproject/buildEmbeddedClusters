#!/bin/bash

INSTALL_DATA_DIR=/home/mpiuser/cloud/1/UTXJetson2_install_packages

#0) Turn on all the CPU and export LC_ALL
nvpmodel -m 2
export LC_ALL=C

#1) Install Python3.6:
add-apt-repository -y ppa:jonathonf/python-3.6
apt-get update
apt-get install -y python3.6

#2.1) Install pip3.6 for Python 3.6 on Ubuntu 16.10
apt-get install -y curl
curl https://bootstrap.pypa.io/get-pip.py | python3.6
echo "pip installed"

#2.2) install python3.6-dev on Ubuntu16.04
add-apt-repository -y ppa:deadsnakes/ppa
apt-get install -y python3.6-dev

#2.4) Install Lapack, scipy will need it
apt-get install -y liblapack-dev

#2) Install TensorFlow-1.3
python3.6 -m pip install "$INSTALL_DATA_DIR/tensorflow-1.3.0-cp36-cp36m-linux_aarch64.whl"

#3) Install Keras
apt-get install -y libhdf5-serial-dev
python3.6 -m pip install --upgrade keras==2.1.3

#Alternative:
#git clone https://github.com/keras-team/keras.git
#cd keras python setup.py install

#4) Install mpi4py
python3.6 -m pip install mpi4py

# Make sure numpy is installed correctly
# (there were issues with scikit-learn's build)
python3.6 -m pip uninstall -y numpy
python3.6 -m pip install numpy

#5) install pandas
python3.6 -m pip install pandas

#6) Matplotlib
apt-get install -y libfreetype6-dev libpng-dev
## python3.6 -m pip install matplotlib
## or
apt-get install -y python3-matplotlib

#7) ScikitLearn
## python3.6 -m pip install --force-reinstall --no-cache-dir scikit-learn==0.21.1
## or
python3.6 -m pip install --upgrade setuptools
python3.6 -m pip install -U setuptools
apt-get install -y libpcap-dev libpq-dev
python3.6 -m pip install cython
## and
python3.6 -m pip install scikit-learn==0.21.1
## or
## pip3 install git+https://github.com/scikit-learn/scikit-learn.git

#8) psutil
python3.6 -m pip install psutil==5.6.3
