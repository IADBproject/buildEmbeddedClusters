#!/bin/bash

## Install CUDA 6.5
mkdir /opt/cuda-6.5/
cd /opt/cuda-6.5/
wget http://developer.download.nvidia.com/compute/cuda/6_5/rel/installers/cuda-repo-l4t-r21.2-6-5-prod_6.5-34_armhf.deb

## Jetson TK1 Version
sudo dpkg -i cuda-repo-l4t-r21.2-6-5-prod_6.5-34_armhf.deb   
sudo apt-get update 
sudo apt-get install cuda-toolkit-6-5

## Install cuDNN library
cp cudnn-6.5-linux-ARMv7-v2/cudnn.h /usr/local/cuda-6.5/include
cp cudnn-6.5-linux-ARMv7-v2/libcudnn* /usr/local/cuda-6.5/lib

## Install CUDA 7.0
