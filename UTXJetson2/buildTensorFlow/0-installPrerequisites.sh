#!/bin/bash

# install prerequisites
apt install -y pkg-config zip g++ zlib1g-dev unzip python3 openjdk-8-jdk build-essential

# TensorFlow build prerequisites
apt install -y python3-dev python3-pip
python3 -m pip install -U pip six numpy wheel setuptools mock 'future>=0.17.1'
python3 -m pip install -U keras_applications==1.0.6 --no-deps
python3 -m pip install -U keras_preprocessing==1.0.5 --no-deps
