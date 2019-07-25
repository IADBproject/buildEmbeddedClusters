#!/bin/bash

MASTER_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/../master_ip_addresses.txt"
EXPORT_DIR="/exports"

apt-get install -y nfs-common

# reset the fstab, unless this is a master (in which case the NFS server setup script has reset it and added an entry already)
if [[ ! "$1" == 1 ]]; then
    echo > /etc/fstab
fi

i=0
while read ip_addr; do
    mountpoint="/home/mpiuser/cloud/$i"
    mkdir -p "$mountpoint"
    echo "$ip_addr:$EXPORT_DIR $mountpoint nfs defaults,proto=tcp,port=2049,user,exec 0 0" >> /etc/fstab
    mount "$mountpoint"
    i=$(( i+1 ))
done < "$MASTER_ADDRESSES_FILE"

chown -R mpiuser "/home/mpiuser/cloud"
chgrp -R mpiuser "/home/mpiuser/cloud"