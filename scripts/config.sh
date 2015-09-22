#!/usr/bin/env bash

echo 'RUNNING CONFIG SETUP....'

echo 'Create Symlinks for moved files'
rm /etc/hosts
ln -s /var/www/hosts /etc/hosts
rm /etc/motd
ln -s /var/www/motd /etc/motd
ln -s /var/www/.vimrc /home/vagrant/.vimrc

# Make conf dir and set permissions
mkdir /var/www/conf > /dev/null 2>&1
chmod -R 777 /var/www/conf
chmod -R g+s /var/www/conf

# Remove default & symlink NGINX conf
rm -rf /etc/nginx/conf.d
ln -s /var/www/conf /etc/nginx/conf.d

chkconfig nginx on
service nginx restart


