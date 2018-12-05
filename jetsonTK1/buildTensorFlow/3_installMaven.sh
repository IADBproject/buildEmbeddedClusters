#!/bin/bash

## Install Maven
sudo apt-get install maven

## Generate the protobuf-java-3.4.1.jar to Jetson Architecture
cd /opt/protobuf

## Check the protobuf version
ls java/core/target/
