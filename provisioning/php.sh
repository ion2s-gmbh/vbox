#!/usr/bin/env bash

add-apt-repository ppa:ondrej/php
apt-get update

echo "Installing ${PHP_VERSION}..."

apt-get install -y \
php${PHP_VERSION}-fpm \
php${PHP_VERSION}-cli \
php${PHP_VERSION}-common \
php${PHP_VERSION}-json \
php${PHP_VERSION}-mysql \
php${PHP_VERSION}-readline \
php${PHP_VERSION}-xml \
php${PHP_VERSION}-curl \
php${PHP_VERSION}-gd \
php${PHP_VERSION}-mbstring \
php${PHP_VERSION}-opcache \
php${PHP_VERSION}-sqlite3 \
php${PHP_VERSION}-zip \
php${PHP_VERSION}-intl

apt-get install -y \
php-xdebug

# Copy configs
cp /vagrant/provisioning/configs/php/xdebug.ini /etc/php/${PHP_VERSION}/mods-available

# Restart PHP
service php${PHP_VERSION}-fpm restart

exit $?
