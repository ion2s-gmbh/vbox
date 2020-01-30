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
```yaml
BOX_BASE: "ubuntu/bionic64"
BOX_NAME: "vbox-origin"
BOX_VERSION: "20190726.0.0"
BOX_IP: "10.0.0.42"
BOX_CPU: 2
BOX_MEMORY: 4096
HOST_SRC_FOLDER: "./src"
```

In `box.yml` you can also configure which provisioning scripts should be executed:
```yaml
provision:
  - php: true
    nginx: true
    nvm: false
    mysql: true
    docker: false
    welcome: true
    frameworks: false
```

### Frameworks
If activated the following framework installers will be installed:
* [Laravel](https://laravel.com/)
* [Lumen](https://lumen.laravel.com/)

You can install the framesworks in the `src` folder by running:
```shell script
cd /var/www/html/src
laravel new <project-name>
# OR
$ lumen new <project-name>
```

## Services
* Nginx
* PHP 7.2
* Composer
* NVM
  * Default NodeJS v12.14.1
  * Default NPM 6.13.4
* Docker
* Docker-Compose
* Mysql

## Databases
Mysql settings and credentials are configured via `box.yml` as well: 
```yaml
mysql:
  MYSQL_DATABASE: mydb
  MYSQL_ROOT_PASSWORD: root!
  MYSQL_USER_NAME: app
  MYSQL_USER_PASSWORD: app!
```

## Owner
* [ion2s GmbH](http://www.ion2s.com)
