#!/bin/sh

# we assume that the guide was followed and the install packages are accessible via NFS
INSTALL_DATA_DIR=/mnt/cluster_data/cluster0/UTXJetson2_install_packages

# cd $(mktemp -d)
cd "$INSTALL_DATA_DIR"

# install CUDA 8.0 and CuDNN 6

dpkg -i cuda-repo-l4t-8-0-local_8.0.84-1_arm64.deb libcudnn6_6.0.21-1+cuda8.0_arm64.deb libcudnn6-dev_6.0.21-1+cuda8.0_arm64.deb
apt-get update
apt-get install -y cuda-toolkit-8-0