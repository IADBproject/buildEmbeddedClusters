#!/bin/bash

sudo apt-get install nfs-kernel-server
sudo mkdir /exports
echo '/dev/sda /exports ext4 defaults 0 2' | tee -a /etc/fstab
sudo mount /exports
echo '/exports 134.59.132.0/24(rw,fsid=0,insecure,no_subtree_check,async)' | tee -a /etc/exports
systemctl restart nfs-kernel-server.service