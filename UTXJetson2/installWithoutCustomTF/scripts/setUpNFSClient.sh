#!/bin/bash

MASTER_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/../master_ip_addresses.txt"

apt-get install -y nfs-common

# reset the fstab
echo > /etc/fstab

i=0
while read ip_addr; do
    mountpoint="/home/mpiuser/cloud/$i"
    mkdir -p "$mountpoint"
    echo "$ip_addr:/exports $mountpoint nfs proto=tcp,port=2049,user 0 0" >> /etc/fstab
    mount "$mountpoint"
    i=$(( i+1 ))
done < "$MASTER_ADDRESSES_FILE"

chown -R mpiuser "/home/mpiuser/cloud"
chgrp -R mpiuser "/home/mpiuser/cloud"