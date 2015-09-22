#!/usr/bin/env bash

# Install remi, remi-test, & epel Yum Repositories
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

# Install RPMforge Yum Repository
rpm -Uvh http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt

# Install kernel-devel
rpm -Uvh http://ftp.pbone.net/mirror/ftp.scientificlinux.org/linux/scientific/6.1/x86_64/updates/security/kernel-devel-2.6.32-358.el6.x86_64.rpm

# Update base
yum -y update
