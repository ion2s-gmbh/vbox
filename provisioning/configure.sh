#!/usr/bin/env bash

cp /vagrant/provisioning/configs/nginx/nginx-default.conf /etc/nginx/sites-available/default

cp /vagrant/provisioning/configs/php/xdebug.ini /etc/php/7.2/mods-available

# Nginx config test
service nginx configtest

# Restart Nginx & PHP
service nginx restart
service php7.2-fpm restart

exit $?
