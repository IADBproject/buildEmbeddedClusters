#!/bin/sh

cd $(mktemp -d)

wget http://mvapich.cse.ohio-state.edu/download/mvapich/mv2/mvapich2-2.3.1.tar.gz
tar zxf mvapich2-2.3.1.tar.gz
cd mvapich2-2.3.1
./configure --disable-mcast
make -j
sudo make install