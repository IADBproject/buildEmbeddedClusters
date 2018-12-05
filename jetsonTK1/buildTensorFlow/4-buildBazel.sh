#!/bin/bash

## 4. Install bazel 
cd /opt
$BAZEL=/opt/bazel

if [ ! -d "$BAZEL" ]; then
  git clone https://github.com/bazelbuild/bazel.git
  cd bazel
  git checkout tags/0.1.4
  
  ## Copy the files generated to Jetson architecture:
  cp /usr/bin/protoc  third_party/protobuf/protoc-linux-arm32.exe
  cp ../protobuf/java/core/target/protobuf-java-3.4.1.jar third_party/protobuf/
  rm third_party/protobufprotobuf-java-3.0.0-beta-1.jar

else
  echo "Working on Bazel directory:" $BAZEL
fi

## Compile Bazel
./compile.sh

## Copy binary
sudo cp output/bazel /usr/local/bin/
