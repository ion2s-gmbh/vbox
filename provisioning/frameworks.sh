#!/usr/bin/env bash

# Composer is required to install framework installers
composer -V
if [ $? -eq 127 ]; then
  echo "PHP is required to install frameworks!"
  exit 1
fi

composer global require laravel/lumen-installer
composer global require laravel/installer

echocmd='export PATH="$PATH:$HOME/.config/composer/vendor/bin"'
bashrc=$(cat ~/.bashrc)

# Do not provision twice
if [[ "$bashrc" != *"$echocmd"* ]]; then
  echo "$echocmd" >>~/.bashrc
fi
