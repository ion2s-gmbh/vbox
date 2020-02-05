#!/usr/bin/env bash

apt-get install apache2 -y

adduser vagrant www-data

# Copy the vhost config
cp /vagrant/provisioning/templates/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php7.2-fpm
sudo a2enmod ssl
sudo systemctl restart apache2

exit $?
