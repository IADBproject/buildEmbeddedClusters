#!/bin/sh

CUDNN_DIR=$(pwd)/cudnn

cd $(mktemp -d)

# download and install CUDA 8.0

wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb

dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb

apt update
apt install -y cuda

# install CuDNN

dpkg -i "$CUDNN_DIR/libcudnn6_6.0.21-1+cuda8.0_amd64.deb"
dpkg -i "$CUDNN_DIR/libcudnn6-dev_6.0.21-1+cuda8.0_amd64.deb"
