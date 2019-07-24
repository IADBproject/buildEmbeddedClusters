#!/bin/bash

# give mpiuser special permissions
echo '## enerGyPU add Not pwd to recording the Jetson Stats
mpiuser ALL = NOPASSWD: /home/mpiuser/cloud/diagnosenet/enerGyPU/dataCapture/enerGyPU_record-jetson.sh
mpiuser ALL = NOPASSWD: /home/mpiuser/cloud/diagnosenet/enerGyPU/dataCapture/tegrastats
mpiuser ALL = NOPASSWD: /usr/bin/killall
mpiuser ALL = NOPASSWD: /usr/sbin/iftop' >> /etc/sudoers.d/diagnosenet

# hostname e.g "astro03"
hostnamectl set-hostname $(printf 'astro%02d' "$1")