#!/bin/bash

## Install the basic requirements:
sudo chmod +x ../buildTensorFlow/*.sh
sudo ./../buildTensorFlow/0-installPrerequisites.sh

## Install the CUDA-6.5, cuDNN and CUDA-7.0
sudo ./../buildTensorFlow/5-installCUDA.sh

## Faster installation for TensorFlow-0.8 on Jetson-TK1
pip install tensorflow-0.8.0-cp27-none-linux_armv7l.whl

## Install Keras-1.2 for TensorFlow-0.8 on Jetson-TK1
sudo pip install keras==1.2
