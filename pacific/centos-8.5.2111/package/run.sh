#!/bin/bash -ex

start_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Build the docker package image start: $start_time"

# CEPH_VERSION is a tag or branch name in git
tag="v16.2.15"
sudo docker build --build-arg "CEPH_VERSION=$tag" -t "ceph-package:centos8-$tag" .

end_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Build the docker package image end: $end_time"