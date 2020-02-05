#!/usr/bin/env bash

openssl genrsa -out /vagrant/files/vbox.key 2048 2> /dev/null

openssl req -new -x509 -key /vagrant/files/vbox.key \
 -out /vagrant/files/vbox.cert \
 -days 3650 -subj /CN=${SERVER_NAME} 2> /dev/null

exit 0
