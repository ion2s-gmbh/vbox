# Vbox

## Description
An easy to use and customize local development environment based on Vagrant and
Virtualbox.

## Usage
1. Clone this Repository
1. Run `vagrant up`

You can enable/disable certain provisioning scripts in the Vagrantfile and run `vagrant provision`
to provision the box accordingly.

## Configuration
You can configure some basic settings of your Vagrant box in `configure/box.yml`.
This settings will be applied in the Vagrant file.
Possible settings:
```yml
BOX_BASE: "ubuntu/bionic64"
BOX_NAME: "vbox-origin"
BOX_VERSION: "20190726.0.0"
BOX_IP: "10.0.0.42"
BOX_CPU: 2
BOX_MEMORY: 4096
HOST_SRC_FOLDER: "./src"
```

## Services
* Nginx
* PHP 7.2
* Composer
* NVM
* Docker
* Docker-Compose
* Mysql

## Databases
Mysql credentials:  
```
user = root
password = root!
```

## Owner
* [ion2s GmbH](http://www.ion2s.com)
