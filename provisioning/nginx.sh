#!/usr/bin/env bash

apt-get install nginx -y

adduser vagrant www-data

# Copy the vhost config
cp /vagrant/provisioning/templates/nginx/nginx-default.conf /etc/nginx/sites-available/default

# Remove the default index page of nginx
if [ -f "/var/www/html/index.nginx-debian.html" ]; then
  echo "Removing nginx default page..."
  rm /var/www/html/index.nginx-debian.html
fi

# Nginx config test
service nginx configtest

# Restart Nginx & PHP
service nginx restart

exit $?
