#!/usr/bin/env bash

cp /vagrant/provisioning/configs/nginx-default.conf /etc/nginx/sites-available/default

# Nginx config test
service nginx configtest

# Restart Nginx & PHP
service nginx restart
service php7.2-fpm restart

exit $?
