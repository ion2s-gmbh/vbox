#!/usr/bin/env bash

FILENAME="composer"
INSTALL_DIR="/opt/composer"

mkdir -p ${INSTALL_DIR}

# https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php \
--filename=${FILENAME} \
--install-dir=${INSTALL_DIR}

RESULT=$?
rm composer-setup.php

ln -s ${INSTALL_DIR}/${FILENAME} /usr/local/bin/${FILENAME}

USER_HOME=/home/vagrant

# Place composer's bin folder in the PATH
mkdir -p ${USER_HOME}/.config/composer/vendor/bin
chown vagrant:vagrant ${USER_HOME}/.config -R
echocmd="export PATH=$PATH:${USER_HOME}/.config/composer/vendor/bin"
bashrc=$(cat ${USER_HOME}/.bashrc)

# Do not provision twice
if [[ "$bashrc" != *"$echocmd"* ]]; then
  echo "$echocmd" >> ${USER_HOME}/.bashrc
fi

exit $RESULT
