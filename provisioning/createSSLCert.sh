#!/usr/bin/env bash

CERTS_FOLDER=/var/certificates

mkdir ${CERTS_FOLDER}

openssl genrsa -out ${CERTS_FOLDER}/vbox.key 2048 2> /dev/null

openssl req -new -x509 -key ${CERTS_FOLDER}/vbox.key \
 -out ${CERTS_FOLDER}/vbox.cert \
 -days 3650 -subj /CN=${SERVER_NAME} 2> /dev/null

exit 0
