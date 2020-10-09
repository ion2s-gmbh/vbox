#!/usr/bin/env bash

## Nodejs is installed via NVM https://github.com/nvm-sh/nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
source /vagrant/provisioning/loadNvm.sh

IFS=' ' read -ra versions <<< "$versions_string"

for version in "${versions[@]}"
do
   nvm install ${version} --latest-npm
done

nvm alias default ${current}

exit $?
