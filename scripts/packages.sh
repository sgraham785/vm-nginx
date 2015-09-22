#!/usr/bin/env bash

echo 'RUNNING PACKAGES FILE....'

echo 'Install Required Packages'
yum -y install nginx yum-utils wget gcc gcc-c++ perl bzip2 bzip2-devel zip unzip curl make automake autoconf libtool nano tar rsync

#yum -y install nginx yum-utils wget nano

echo 'Install VIM'
yum -y install vim-X11 vim-common vim-enhanced vim-minimal

#echo 'Install Ruby & Python'
yum -y install ruby ruby-devel rubygems python python-devel perl-devel

# Update everything
yum -y upgrade
