# Vbox

## Description
An easy to use and customize local development environment based on Vagrant and
Virtualbox.

## Usage
1. Clone this Repository
1. Run `vagrant up`
1. By default no custom provisioning scripts will be executed.

You can enable certain provisioning scripts in the Vagrantfile and run `vagrant provision`
to provision the box accordingly.

## Default settings
* Private IP address of the box: 10.0.0.42
* CPU: 2
* Memory: 4096

## Services
* Nginx

## Owner
* [ion2s GmbH](http://www.ion2s.com)
