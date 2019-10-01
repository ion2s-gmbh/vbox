#!/usr/bin/env bash

apt-get update
apt-get install nginx -y

adduser www-data vagrant

exit $?
