<div align="center"><a name="readme-top"></a>

<img src="./static/logo.png" width="15%"/>

# Ceph-Image

`ceph-image` is a project used to build Docker images for Ceph.

[简体中文](./README.md) · **English**

</div>

## Introduction

The generated images are divided into three types:

1. **Development Environment Image (dev)** : Used for development environments.
2. **Packaging Image (package)** : Used for packaging Ceph RPMs.
3. **Deployment Image (deploy)** : Used for deploying Ceph with ceph-ansible.

## Supported Base Environments

The currently supported base environments for generating Docker images are:

- CentOS 8.4.2106 (`docker.io/library/centos:8.4.2105`)
- CentOS 8.5.2111 (`docker.io/roboxes/centos8:4.3.14`)

Please note that since the official CentOS in Docker Hub does not provide an image for CentOS 8.5.2111, the CentOS 8.5.2111 image here comes from a third party.

## Supported Ceph Versions

The currently supported Ceph versions are:

- Pacific
- Quincy
- Reef

Tested versions are:

- v16.2.15
- v17.2.7
- v18.2.4

---