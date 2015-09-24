#!/usr/bin/env bash

echo 'RUNNING NODEJS INSTALL....'

curl --silent --location https://rpm.nodesource.com/setup | bash -

echo 'Install Nodejs & NPM'
yum -y install nodejs
yum install gcc-c++ make

echo 'Update NPM...'
npm install -g npm
npm -v

echo 'Install Gulp'
npm install gulp -g

echo 'Output versions'
node --version
gulp -v