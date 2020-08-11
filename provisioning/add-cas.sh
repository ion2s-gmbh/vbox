#!/usr/bin/env bash

rm -rf /usr/local/share/ca-certificates/extra

mv /home/vagrant/extra /usr/local/share/ca-certificates

update-ca-certificates

exit $?
