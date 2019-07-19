#!/bin/bash

BLOCKDEV='/dev/sda'

apt-get install -y nfs-kernel-server

echo "Checking if formatted..."
# prepare the file system
if [[ $(file -s "$BLOCKDEV") != *"ext4"* ]]; then
    echo "Formatting $BLOCKDEV..."
    # the file system isn't formatted as needed, do it
    mkfs.ext4 "$BLOCKDEV"
fi

# mount it
mkdir -p /exports
echo '/dev/sda /exports ext4 defaults 0 2' | tee -a /etc/fstab
mount /exports

# export it
echo '/exports 134.59.132.0/24(rw,fsid=0,insecure,no_subtree_check,async)' | tee -a /etc/exports
systemctl restart nfs-kernel-server.service