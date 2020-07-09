#!/usr/bin/env bash

INSTALL_DIR=/tmp/ioncube

if [ ! -d "${INSTALL_DIR}" ]; then
  mkdir -p ${INSTALL_DIR}
  wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
  tar xvfz ioncube_loaders_lin_x86-64.tar.gz
fi

# EXTENSION_DIR=$(php -i | grep ^"extension_dir")
# EXTENSION_DIR=${EXTENSION_DIR##*=>}
EXTENSION_DIR=/usr/lib/php/ioncube

if [ ! -d "${EXTENSION_DIR}" ]; then
  mkdir -p ${EXTENSION_DIR}
fi

if [ ! -f "${EXTENSION_DIR}/ioncube_loader_lin_${PHP_VERSION}.so" ]; then
  cp -v ioncube/ioncube_loader_lin_${PHP_VERSION}.so ${EXTENSION_DIR}
fi

INI_CONTENT="zend_extension=${EXTENSION_DIR}/ioncube_loader_lin_${PHP_VERSION}.so"
echo ${INI_CONTENT} > /etc/php/${PHP_VERSION}/mods-available/ioncube.ini

CLI_LINK="/etc/php/${PHP_VERSION}/cli/conf.d/00-ioncube.ini"
FPM_LINK="/etc/php/${PHP_VERSION}/fpm/conf.d/00-ioncube.ini"

if [ ! -L ${CLI_LINK} ]; then
  echo "Creating symlink for ioncube in php cli..."
  ln -s -v /etc/php/${PHP_VERSION}/mods-available/ioncube.ini ${CLI_LINK}
fi

if [ ! -L ${FPM_LINK} ]; then
  echo "Creating symlink for ioncube in php fpm..."
  ln -s -v /etc/php/${PHP_VERSION}/mods-available/ioncube.ini ${FPM_LINK}
fi

service php${PHP_VERSION}-fpm restart
