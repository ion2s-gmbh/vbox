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

echo "alias art='php artisan'" >> /home/vagrant/.bash_aliases

# Yii PHP Framework
mkdir -p $HOME/framework-installers
cp /vagrant/provisioning/scripts/yii-installer.sh $HOME/framework-installers/
chmod +x $HOME
sudo ln -s /home/vagrant/framework-installers/yii-installer.sh /usr/local/bin/yii-create

# Symfony Framework
wget https://get.symfony.com/cli/installer -O - | bash
sudo ln -s /home/vagrant/.symfony/bin/symfony /usr/local/bin/symfony

exit 0
