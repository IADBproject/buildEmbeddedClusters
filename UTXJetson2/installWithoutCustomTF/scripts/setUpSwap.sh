#!/bin/bash

SWAPFILE="/swapfile"

fallocate -l 4G "$SWAPFILE"
chown root "$SWAPFILE"
chmod 0600 "$SWAPFILE"
mkswap "$SWAPFILE"

echo "$SWAPFILE none swap sw 0 0" >> /etc/fstab
swapon "$SWAPFILE"