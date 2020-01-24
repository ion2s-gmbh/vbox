#!/usr/bin/env bash

apt-get install nginx -y

adduser www-data vagrant
adduser vagrant www-data

# Copy the vhost config
cp /vagrant/provisioning/configs/nginx/nginx-default.conf /etc/nginx/sites-available/default

# Remove the default index page of nginx
rm /var/www/html/index.nginx-debian.html

# Nginx config test
service nginx configtest

# Restart Nginx & PHP
service nginx restart

exit $?
