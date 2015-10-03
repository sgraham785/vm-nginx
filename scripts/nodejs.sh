#!/usr/bin/env bash

echo 'RUNNING NODEJS INSTALL....'

#curl --silent --location https://rpm.nodesource.com/setup | bash -

# update gcc
wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtoolset-2.repo
yum -y install devtoolset-2-gcc-4.8.2 devtoolset-2-gcc-c++-4.8.2 devtoolset-2-binutils make
/opt/rh/devtoolset-2/root/usr/bin/gcc --version
rm -rf /usr/bin/gcc
ln -s /opt/rh/devtoolset-2/root/usr/bin/gcc /usr/bin/gcc
gcc --version

rm -rf /usr/bin/g++
ln -s /opt/rh/devtoolset-2/root/usr/bin/g++ /usr/bin/g++

rm -rf /usr/bin/ar
ln -s /opt/rh/devtoolset-2/root/usr/bin/ar /usr/bin/ar

rm -rf /usr/bin/as
ln -s /opt/rh/devtoolset-2/root/usr/bin/as /usr/bin/as



echo 'Install Node v4.1.1 & NPM'
cd /usr/src
wget http://nodejs.org/dist/v4.1.1/node-v4.1.1.tar.gz
tar zxvf node-v4.1.1.tar.gz
cd node-v4.1.1
./configure
make && make install

ln -s /usr/local/bin/node /usr/bin/node
node -v

ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

echo 'Update NPM...'
npm update -g npm
npm -v

echo 'Install Gulp'
npm install gulp -g

echo 'Install Nodemon'
npm install -g nodemon

echo 'Output versions'
node --version
gulp -v