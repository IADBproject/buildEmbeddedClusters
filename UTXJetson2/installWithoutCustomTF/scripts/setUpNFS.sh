#!/bin/sh

apt-get install -y nfs-common

mkdir -p /mnt/cluster_data/cluster0
mount -t nfs -o proto=tcp,port=2049 134.59.132.200:/exports /mnt/cluster_data/cluster0