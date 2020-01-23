#!/usr/bin/env bash

apt-get install nginx -y

adduser www-data vagrant
adduser vagrant www-data

exit $?
