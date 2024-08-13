#!/bin/bash -ex

start_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Build the docker deploy image start: $start_time"

# CEPH_VERSION is a tag or branch name in git
tag="v17.2.7"
sudo docker build --build-arg "CEPH_VERSION=$tag" -t "ceph-deploy:centos8-$tag" .

end_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Build the docker deploy image end: $end_time"