<div align="center"><a name="readme-top"></a>

<img src="./static/logo.png" width="15%"/>

# Ceph-Image

`ceph-image` 是一个用于构建 Ceph 的 Docker 镜像的项目。

 **简体中文** · [English](./README-en.md)

</div>

## 简介

该项目生成的镜像分为三种类型：

1. **开发环境镜像（dev）** ：用于开发环境。
2. **打包镜像（package）** ：用于打包 Ceph 的 RPM 包。
3. **部署镜像（deploy）** ：用于使用 ceph-ansible 部署 Ceph。

## 支持的基础环境

目前支持生成的 Docker 镜像的基础环境为：

- CentOS 8.4.2106（`docker.io/library/centos:8.4.2105`）
- CentOS 8.5.2111（`docker.io/roboxes/centos8:4.3.14`）

需要注意的是，由于 Docker Hub 中的 CentOS 官方并没有提供 CentOS 8.5.2111 的镜像，所以这里 CentOS 8.5.2111 的镜像来源于第三方。

## 支持的 Ceph 版本

目前支持的 Ceph 版本为：

- Pacific
- Quincy
- Reef

经过测试的版本信息为：

- v16.2.15
- v17.2.7
- v18.2.4

---