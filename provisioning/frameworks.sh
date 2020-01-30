#!/usr/bin/env bash

# Composer is required to install framework installers
composer -V
if [ $? -eq 127 ]; then
  echo "PHP is required to install frameworks!"
  exit 1
fi

# Laravel & Lumen
composer global require laravel/lumen-installer
composer global require laravel/installer

# Yii PHP Framework
mkdir -p $HOME/framework-installers
cp /vagrant/provisioning/scripts/yii-installer.sh $HOME/framework-installers/
chmod +x $HOME
sudo ln -s /home/vagrant/framework-installers/yii-installer.sh /usr/local/bin/yii-create
