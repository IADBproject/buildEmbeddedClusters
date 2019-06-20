#!/bin/bash

# Bazel install prerequisites
sudo apt install pkg-config zip g++ zlib1g-dev unzip python3

# TensorFlow build prerequisites
sudo apt install python3-dev python3-pip
python3 -m pip install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
python3 -m pip install -U --user keras_applications==1.0.6 --no-deps
python3 -m pip install -U --user keras_preprocessing==1.0.5 --no-deps
