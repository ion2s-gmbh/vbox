#!/usr/bin/env bash

add-apt-repository ppa:ondrej/php
apt-get update

echo "Installing ${PHP_VERSION}..."

apt-get install -y \
php${PHP_VERSION}-fpm \
php${PHP_VERSION}-cli \
php-xdebug

apt-get install -y \
${PHP_MODULES}

# Copy configs
cp /vagrant/provisioning/configs/php/xdebug.ini /etc/php/${PHP_VERSION}/mods-available

# Restart PHP
service php${PHP_VERSION}-fpm restart

exit $?
