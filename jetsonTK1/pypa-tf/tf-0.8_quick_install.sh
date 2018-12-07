#!/bin/bash

## Install the basic requirements:
chmod +x ../buildTensorFlow/*.sh
./../buildTensorFlow/0-installPrerequisites.sh

## Install the CUDA-6.5, cuDNN and CUDA-7.0
./../buildTensorFlow/5-installCUDA.sh

## Faster installation for TensorFlow-0.8 on Jetson-TK1
pip install tensorflow-0.8.0-cp27-none-linux_armv7l.whl
