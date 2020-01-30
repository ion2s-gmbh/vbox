#!/usr/bin/env bash

apt-get install apache2 -y

adduser vagrant www-data

# Copy the vhost config
#cp /vagrant/provisioning/configs/nginx/nginx-default.conf /etc/nginx/sites-available/default

# Remove the default index page of nginx
#rm /var/www/html/index.nginx-debian.html

sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php7.2-fpm
sudo systemctl reload apache2

exit $?
