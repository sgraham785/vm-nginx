#!/usr/bin/env bash

/usr/sbin/setenforce 0
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

# Install Base Yum
#yum -y install yum-utils wget gcc gcc-c++ perl bzip2 bzip2-devel zip unzip curl make automake autoconf libtool nano tar

yum -y install yum-utils wget

# Install Base Utils
yum -y --enablerepo=epel,remi,remi-test,rpmforge install dkms

yum -y --enablerepo=epel,remi,remi-test,rpmforge groupinstall "Development Tools"

yum -y --enablerepo=epel,remi,remi-test,rpmforge install zlib-devel openssl-devel nfs-utils nfs-utils-lib bind-utils pcre-devel rpcbind portmap nfs-common

yum -y --enablerepo=epel,remi,remi-test,rpmforge,kernel-devel install kernel-devel kernel-headers-`uname -r` kernel-devel-`uname -r`
