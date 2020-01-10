# Vbox

## Description
An easy to use and customize local development environment based on Vagrant and
Virtualbox.

## Usage
1. Clone this Repository
1. Run `vagrant up`

You can enable/disable certain provisioning scripts in the Vagrantfile and run `vagrant provision`
to provision the box accordingly.

## Default settings
* Private IP address of the box: 10.0.0.42
* CPU: 2
* Memory: 4096

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
