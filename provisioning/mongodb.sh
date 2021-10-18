#!/usr/bin/env bash

sudo apt-get install -y mongodb

cp /vagrant/provisioning/configs/mongodb/mongodb.conf /etc/mongodb.conf

service mongodb restart

exit $?
