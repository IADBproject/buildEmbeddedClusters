#!/bin/bash

## Install CUDA 6.5
mkdir /opt/cuda-6.5/
cd /opt/cuda-6.5/
wget http://developer.download.nvidia.com/compute/cuda/6_5/rel/installers/cuda-repo-l4t-r21.2-6-5-prod_6.5-34_armhf.deb
sudo dpkg -i cuda-repo-l4t-r21.2-6-5-prod_6.5-34_armhf.deb   
sudo apt-get update 
sudo apt-get install cuda-toolkit-6-5

## Install cuDNN-6.5 library from buildEmbeddedClusters repository
cd /opt/buildEmbeddedClusters/jetsonTK1/pypa-tf/
sudo cp ../buildTensorFlow/cudnn-6.5-linux-ARMv7-v2/cudnn.h /usr/local/cuda-6.5/include
sudo cp ../buildTensorFlow/cudnn-6.5-linux-ARMv7-v2/libcudnn* /usr/local/cuda-6.5/lib

## Install CUDA 7.0
mkdir /opt/cuda-7.0/
cd /opt/cuda-7.0/
wget http://developer.download.nvidia.com/embedded/L4T/r24_Release_v1.0/CUDA/cuda-repo-l4t-7-0-local_7.0-76_armhf.deb
sudo dpkg -i cuda-repo-l4t-7-0-local_7.0-76_armhf.deb 
sudo apt-get update
sudo apt-get install cuda-toolkit-7-0

## Build a symbolic link to cuda-6.5
cd /usr/local   
sudo rm cuda   
sudo ln -s cuda-6.5/ cuda

## Add path to .bashrc
echo "export CPATH=/usr/local/cuda/include:$CPATH" >> ~/.bashrc   
echo "export PATH=/usr/local/cuda-6.5/bin:$PATH" >> ~/.bashrc

## Enables cuda-7.0/lib for compiling Tensorflow
## echo "export LD_LIBRARY_PATH=/usr/local/cuda-7.0/lib:$LD_LIBRARY_PATH" >> ~/.bashrc

## Enables cuda-6.5/libe to execute Tensorflow 
echo "export LD_LIBRARY_PATH=/usr/local/cuda-6.5/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc
