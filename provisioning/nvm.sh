#!/usr/bin/env bash

## Nodejs is installed via NVM https://github.com/nvm-sh/nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

source /vagrant/provisioning/loadNvm.sh

nvm install --lts=Erbium --latest-npm
nvm alias default stable

exit $?
