#!/usr/bin/env bash

mkdir -p $HOME/framework-installers

# Composer is required to install framework installers
composer -V
if [ $? -eq 127 ]; then
  echo "PHP is required to install frameworks!"
  exit 1
fi

# Laravel & Lumen
composer global require laravel/lumen-installer
composer global require laravel/installer

echo "alias art='php artisan'" >> /home/vagrant/.bash_aliases

# Yii & Laminas PHP Framework
cp /vagrant/provisioning/scripts/frameworks/* $HOME/framework-installers/
chmod +x $HOME/framework-installers/ -R
sudo ln -s /home/vagrant/framework-installers/yii-installer.sh /usr/local/bin/yii-create
sudo ln -s /home/vagrant/framework-installers/laminas-installer.sh /usr/local/bin/laminas-create

# Symfony Framework
wget https://get.symfony.com/cli/installer -O - | bash
sudo ln -s /home/vagrant/.symfony/bin/symfony /usr/local/bin/symfony

exit 0
