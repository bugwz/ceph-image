#!/bin/bash -ex

start_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Build the docker dev image start: $start_time"

# CEPH_VERSION is a tag or branch name in git
tag="v19.2.1"
sudo docker build --build-arg "CEPH_VERSION=$tag" -t "ceph-dev:centos9-stream-$tag" .

end_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Build the docker dev image end: $end_time"