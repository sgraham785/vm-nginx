#!/usr/bin/env bash

echo 'RUNNING PHP INSTALL....'

yum -y install https://mirror.webtatic.com/yum/el6/latest.rpm

#yum -y install https://mirror.webtatic.com/yum/el7/epel-release.rpm
#yum -y install https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

echo 'Install PHP 5.5'
yum -y install php55w php55w-opcache php55w-common php55w-pdo php55w-pecl-memcache php55w-pgsql php55w-mcrypt php55w-mbstring php55w-bcmath php55w-cli php55w-pecl-xdebug php55w-gd php55w-mysql

if [ -f /etc/php.ini ]; then
  echo 'Increase realpath cache size and ttl'
  sed -i "s/;realpath_cache_size = 16k/realpath_cache_size = 1024k/" /etc/php.ini
  sed -i "s/;realpath_cache_ttl = 120/realpath_cache_ttl = 3600/" /etc/php.ini
fi

echo 'Install Composer'
curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin
mv /bin/composer.phar /bin/composer
