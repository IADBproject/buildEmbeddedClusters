#!/bin/sh

cd $(mktemp -d)
wget https://github.com/bazelbuild/bazel/releases/download/0.4.5/bazel-0.4.5-installer-linux-x86_64.sh
chmod +x bazel-0.4.5-installer-linux-x86_64.sh
./bazel-0.4.5-installer-linux-x86_64.sh --user