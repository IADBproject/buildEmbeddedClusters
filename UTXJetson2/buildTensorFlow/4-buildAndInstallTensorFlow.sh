#!/bin/sh

cd $(mktemp -d)

wget https://github.com/tensorflow/tensorflow/archive/v1.3.1.tar.gz
tar zxf v1.3.1.tar.gz
cd tensorflow-1.3.1

# configure with
# - python exec: /usr/bin/python3
# - HDFS
# - CUDA
# - MPI
echo '/usr/bin/python3\n\n\n\n\n\ny\n\n\n\ny\n\n\n\n\n\n\n6.2\ny\n/usr/local\n' | ./configure

"$HOME/bazel" build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
build_dir=$(mktemp -d)
./bazel-bin/tensorflow/tools/pip_package/build_pip_package "$build_dir"
cd "$build_dir"
python3 -m pip install tensorflow-1.3.1-cp35-cp35m-linux_x86_64.whl
