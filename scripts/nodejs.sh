#!/usr/bin/env bash

echo 'RUNNING NODEJS INSTALL....'

echo 'Install Nodejs & NPM'
yum -y install nodejs npm

echo 'Update NPM...'
npm install -g npm
npm -v

echo 'Install Gulp'
npm install gulp -g

echo 'Output versions'
node --version
gulp -v