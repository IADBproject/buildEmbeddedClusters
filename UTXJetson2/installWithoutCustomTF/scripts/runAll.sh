#!/bin/bash

echo "Running all the installation scripts."

SCRIPT_DIR=$(dirname "$BASH_SOURCE")

echo "Running \`dpkg --configure -a\` in case dpkg was interrupted before..."
dpkg --configure -a

echo "Setting up SSH..."
"$SCRIPT_DIR/setUpSSH.sh"
echo "Setting up NFS..."
"$SCRIPT_DIR/setUpNFS.sh"
echo "Installing CUDA..."
"$SCRIPT_DIR/installCUDA.sh"
echo "Installing TensorFlow..."
"$SCRIPT_DIR/tf-1.3_quick_install.sh"