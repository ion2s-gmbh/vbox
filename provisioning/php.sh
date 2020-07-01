#!/usr/bin/env bash

add-apt-repository ppa:ondrej/php
apt-get update

echo "Installing ${PHP_VERSION}..."

apt-get install -y \
php${PHP_VERSION}-fpm \
php${PHP_VERSION}-cli \
php-xdebug \
php-memcached \
php-redis

apt-get install -y \
${PHP_MODULES}

# Copy configs
cp /vagrant/provisioning/configs/php/xdebug.ini /etc/php/${PHP_VERSION}/mods-available

# Restart PHP
service php${PHP_VERSION}-fpm restart

if [ "$PHP_CURRENT" = "$PHP_VERSION" ]; then
  echo "Setting current php version..."
  update-alternatives --set php /usr/bin/php${PHP_VERSION}
fi

exit $?
