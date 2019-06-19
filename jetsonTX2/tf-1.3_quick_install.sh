#!/bin/bash

#0) Turn on all the CPU and export LC_ALL
sudo nvpmodel -m 2
export LC_ALL=C

#1) Install Python3.6:
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get install python3.6

#2.1) Install pip3.6 for Python 3.6 on Ubuntu 16.10
sudo apt-get install curl
curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3.6

#2.2) install python3.6-dev on Ubuntu16.04
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get install python3.6-dev

#2) Install TensorFlow-1.3
cd pypa-tf/
sudo pip3.6 install tensorflow-1.3.0-cp36-cp36m-linux_aarch64.whl

#3) Install Keras
sudo apt-get install libhdf5-serial-dev
sudo pip3.6 install --upgrade keras==2.1.3

#Alternative:
#git clone https://github.com/keras-team/keras.git
#cd keras sudo python setup.py install

#4) Install mpi4py
sudo pip3.6 install mpi4py

#5) install pandas
sudo -H pip3.6 install pandas

#6) Matplotlib
sudo apt-get install libfreetype6-dev libpng-dev
## sudo pip3.6 install matplotlib
## or
sudo apt-get install python3-matplotlib

#7) ScikitLearn
## sudo pip3.6 install --force-reinstall --no-cache-dir scikit-learn==0.21.1
## or
sudo pip3.6 install --upgrade setuptools
sudo pip3.6 install -U setuptools
sudo apt-get install libpcap-dev libpq-dev
sudo pip3.6 install cython
## and
sudo pip3.6 install scikit-learn==0.21.1
## or
## sudo pip3 install git+https://github.com/scikit-learn/scikit-learn.git
