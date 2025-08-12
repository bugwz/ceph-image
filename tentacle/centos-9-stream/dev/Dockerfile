FROM quay.io/centos/centos:stream9 as builder
ARG CEPH_VERSION=v20.3.0
COPY files /tmp/
RUN rm -rf /etc/yum.repos.d/*.repo* \
    && mv /tmp/centos-addons.repo /etc/yum.repos.d/ \
    && mv /tmp/centos.repo /etc/yum.repos.d/ \
    && mv /tmp/centos-epel-all.repo /etc/yum.repos.d/ \
    && dnf clean all \
    && dnf install -y epel-release \
    && rm -rf /etc/yum.repos.d/epel* \
    && dnf groupinstall -y 'development tools' \
    && dnf install -y kernel-headers zlib zlib-devel bzip2-devel openssl openssl-devel \
       sqlite-devel readline-devel wget createrepo jsonnet nodejs git bc ruby ruby-devel \
       python3-jinja2 doxygen nginx snappy csnappy csnappy-devel libffi libffi-devel \
       binutils-devel libyaml-devel facter perl perl-File-Slurp perl-List-MoreUtils \
       perl-XML-LibXML perl-YAML-LibYAML perl-DateTime perl-MCE perl-Sereal genders isa-l \
       c-ares-devel cryptopp-devel gnutls-devel hwloc-devel libasan libpciaccess-devel \
       libubsan lksctp-tools-devel numactl-devel protobuf-compiler protobuf-devel ragel \
       python3-ply libaio-devel libuuid-devel systemd-devel gcc-toolset-13-gcc-c++ \
       gcc-toolset-13-gcc-plugin-annobin gcc-toolset-13-libasan-devel gcc-toolset-13-libatomic-devel \
       gcc-toolset-13-libubsan-devel gcc-toolset-13-runtime \
    && dnf reinstall -y kernel-headers glibc-headers csnappy-devel snappy csnappy-devel rpm-build rpmdevtools \
    && rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && curl https://pyenv.run | bash \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && rm -rf /root/.bashrc \
    && mv /tmp/bashrc /root/.bashrc
RUN source /root/.bashrc \
    && mkdir -p /tmp/openssl \
    && cd /tmp/openssl \
    && wget https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_0l/openssl-1.1.0l.tar.gz \
    && tar -zxvf openssl-1.1.0l.tar.gz \
    && cd openssl-1.1.0l \
    && ./config --prefix=/usr/local/openssl-1.1.0l --openssldir=/usr/local/openssl-1.1.0l \
    && make \
    && make install \
    && ln -s /usr/local/openssl-1.1.0l/lib/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.1 \
    && ln -s /usr/local/openssl-1.1.0l/lib/libssl.so.1.1 /usr/lib64/libssl.so.1.1 \
    && cd / \
    && rm -rf /tmp/openssl
RUN source /root/.bashrc \
    && mkdir -p /tmp/python27 \
    && cd /tmp/python27 \
    && wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz \
    && tar -zxvf Python-2.7.18.tgz \
    && cd Python-2.7.18 \
    && ./configure CPPFLAGS="-I /usr/local/openssl-1.1.0l/include" LDFLAGS="-L /usr/local/openssl-1.1.0l/lib" \
        --enable-optimizations --enable-shared --prefix=/usr/local/python2.7.18 \
    && make \
    && make altinstall \
    && ln -s /usr/local/python2.7.18/bin/python2.7 /usr/bin/python2 \
    && ln -s /usr/local/python2.7.18/bin/python2.7 /usr/bin/python2.7 \
    && ln -s /usr/local/python2.7.18/bin/python2.7-config /usr/bin/python2.7-config \
    && ln -s /usr/local/python2.7.18/lib/libpython2.7.so.1.0 /usr/lib64/libpython2.7.so \
    && ln -s /usr/local/python2.7.18/lib/libpython2.7.so.1.0 /usr/lib64/libpython2.7.so.1.0 \
    && cd / \
    && rm -rf /tmp/python27
RUN source /root/.bashrc \
    && mkdir -p /tmp/cortx \
    && cd /tmp/cortx \
    && wget https://github.com/Seagate/cortx-motr/releases/download/2.0.0-rgw/libfabric-1.11.2-1.el7.x86_64.rpm \
    && wget https://github.com/Seagate/cortx-motr/releases/download/2.0.0-rgw/libfabric-devel-1.11.2-1.el7.x86_64.rpm \
    && wget https://github.com/Seagate/cortx-motr/releases/download/2.0.0-rgw/cortx-motr-2.0.0-1_git3252d623_any.el8.x86_64.rpm \
    && wget https://github.com/Seagate/cortx-motr/releases/download/2.0.0-rgw/cortx-motr-devel-2.0.0-1_git3252d623_any.el8.x86_64.rpm \
    && wget https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/r/rubygem-net-ssh-5.1.0-2.el8.noarch.rpm \
    && rpm -ivh --nodeps "*.rpm" \
    && cd / \
    && rm -rf /tmp/cortx
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
    && git submodule update --init --recursive

FROM scratch
COPY --from=builder / /
CMD ["/bin/bash"]