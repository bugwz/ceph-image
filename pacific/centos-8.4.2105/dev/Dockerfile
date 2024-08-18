FROM docker.io/library/centos:8.4.2105 as builder
ARG CEPH_VERSION=pacific
COPY files /tmp/
RUN rm -rf /etc/yum.repos.d/*.repo* \
    && mv /tmp/centos-all.repo /etc/yum.repos.d/ \
    && mv /tmp/centos-stream-all.repo /etc/yum.repos.d/ \
    && mv /tmp/epel-all.repo /etc/yum.repos.d/ \
    && dnf clean all \
    && dnf groupinstall -y 'development tools' \
    && dnf install -y kernel-headers zlib zlib-devel bzip2-devel openssl-devel \
       sqlite-devel readline-devel python2-devel python36-devel python38-devel python2-jinja2 \
       python3-jinja2 python38-jinja2 git bc doxygen nginx snappy csnappy csnappy-devel libffi \
       libffi-devel createrepo jsonnet nodejs wget xz xz-devel libmodulemd-2.13.0 glibc-common \
       glibc-langpack-en glibc-langpack-zh \
    && dnf reinstall -y kernel-headers glibc-headers csnappy-devel snappy csnappy-devel rpm-build rpmdevtools \
    && rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && curl https://pyenv.run | bash \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && rm -rf /root/.bashrc \
    && mv /tmp/bashrc /root/.bashrc
RUN source /root/.bashrc \
    && mkdir -p /root/.pyenv/cache/ \
    && wget https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tar.xz -O /root/.pyenv/cache/Python-3.6.15.tar.xz \
    && wget https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tar.xz -O /root/.pyenv/cache/Python-3.8.16.tar.xz \
    && pyenv install 3.6.15 3.8.16 \
    && pyenv global 3.8.16 \
    && rm -rf /root/.pyenv/cache/Python-3.6.15.tar.xz \
    && rm -rf /root/.pyenv/cache/Python-3.8.16.tar.xz \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip config set install.trusted-host https://pypi.tuna.tsinghua.edu.cn \
    && pip install pip setuptools wheel Cython IPy boto boto3 xmltodict jwt prettytable --upgrade \
    && nvm install 12.20.0 \
    && npm config set registry https://registry.npmmirror.com
RUN cd /root/ \
    && git clone https://github.com/ceph/ceph.git \
    && cd /root/ceph \
    && git checkout -f ${CEPH_VERSION} \
    && git submodule update --init --recursive \
    && export FOR_MAKE_CHECK=true; /root/ceph/install-deps.sh \
    && /root/ceph/do_cmake.sh \
    && cd /root/ceph/build/ \
    && make -j "$(expr $(nproc) / 2)"

FROM scratch
COPY --from=builder / /
CMD ["/bin/bash"]