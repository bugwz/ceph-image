#!/bin/bash

# action 1: build ceph
cd /root/ceph/
git checkout -f v19.2.1
git pull origin v19.2.1
git submodule update --init --recursive
export FOR_MAKE_CHECK=true
/root/ceph/install-deps.sh
/root/ceph/do_cmake.sh
cd /root/ceph/build/
ninja -j "$(expr $(nproc) / 2)"

# action 2: build ceph with crimson
cd /root/ceph/
git checkout -f v19.2.1
git pull origin v19.2.1
git submodule update --init --recursive
export FOR_MAKE_CHECK=true
export WITH_CRIMSON=true
/root/ceph/install-deps.sh
/root/ceph/do_cmake.sh
cd /root/ceph/build/
ninja -j "$(expr $(nproc) / 2)"

# action 3: build ceph rpm
cd /root/ceph/
git checkout -f v19.2.1
git pull origin v19.2.1
git submodule update --init --recursive
/root/ceph/make-dist
mkdir -p /root/ceph/rpmbuild/SOURCES
cp /root/ceph/ceph-*.tar.bz2 /root/ceph/rpmbuild/SOURCES
rpmbuild -ba --clean --rmsource --rmspec \
    --define="_topdir /root/ceph/rpmbuild" \
    --define="_rpmdir /root/ceph/rpmbuild/RPMS" \
    --define="_builddir /root/ceph/rpmbuild/BUILD" \
    --define="_sourcedir /root/ceph/rpmbuild/SOURCES" \
    --define="_specdir /root/ceph/rpmbuild/SPECS" \
    --define="_srcrpmdir /root/ceph/rpmbuild/SRPMS" \
    --define="_unpackaged_files_terminate_build 0" \
    ceph.spec --without selinux
createrepo /root/ceph/rpmbuild/RPMS/x86_64/
createrepo /root/ceph/rpmbuild/RPMS/noarch/

# action 4: build ceph rpm with crimson
cd /root/ceph/
git checkout -f v19.2.1
git pull origin v19.2.1
git submodule update --init --recursive
/root/ceph/make-dist
mkdir -p /root/ceph/rpmbuild/SOURCES
cp /root/ceph/ceph-*.tar.bz2 /root/ceph/rpmbuild/SOURCES
rpmbuild -ba --clean --rmsource --rmspec \
    --define="_topdir /root/ceph/rpmbuild" \
    --define="_rpmdir /root/ceph/rpmbuild/RPMS" \
    --define="_builddir /root/ceph/rpmbuild/BUILD" \
    --define="_sourcedir /root/ceph/rpmbuild/SOURCES" \
    --define="_specdir /root/ceph/rpmbuild/SPECS" \
    --define="_srcrpmdir /root/ceph/rpmbuild/SRPMS" \
    --define="_unpackaged_files_terminate_build 0" \
    ceph.spec --without selinux --with crimson
createrepo /root/ceph/rpmbuild/RPMS/x86_64/
createrepo /root/ceph/rpmbuild/RPMS/noarch/