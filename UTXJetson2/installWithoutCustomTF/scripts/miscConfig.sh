#!/bin/bash

# give mpiuser special permissions
echo '## enerGyPU add Not pwd to recording the Jetson Stats
mpiuser ALL = NOPASSWD: /home/mpiuser/cloud/0/diagnosenet/enerGyPU/dataCapture/enerGyPU_record-jetson.sh
mpiuser ALL = NOPASSWD: /home/mpiuser/cloud/0/diagnosenet/enerGyPU/dataCapture/tegrastats
mpiuser ALL = NOPASSWD: /usr/bin/killall
mpiuser ALL = NOPASSWD: /usr/sbin/iftop' > /etc/sudoers.d/diagnosenet

# hostname e.g "astro03"
newname=$(printf 'astro%02d' "$1")
hostnamectl set-hostname "$newname"
echo "127.0.0.1 localhost" > /etc/hosts
echo "127.0.1.1 $newname" >> /etc/hosts

# add all nodes to /etc/hosts
IP_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/../node_ip_addresses.txt"

i=0
while read ip_addr; do
    echo "$ip_addr astro$i" >> /etc/hosts
    i=$(( $i + 1 ))
done < "$IP_ADDRESSES_FILE"