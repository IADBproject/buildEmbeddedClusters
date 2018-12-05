#!/bin/bash

## 2. Build Protobuf

## Download the latest protobuf source from github:
sudo chown -R ubuntu:ubuntu /opt
cd /opt
git clone https://github.com/google/protobuf.git

## Checkout to get libprotoc in the version 3.4.0 
cd /opt/protobuf
git checkout tags/3.4.0

## First generate the configuration file
./autogen.sh
./configure --prefix=/usr

## Then run make
make -j 4
sudo make install
protoc --version
