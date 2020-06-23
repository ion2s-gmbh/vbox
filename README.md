# Vbox

## Description
An easy to use and customize local development environment based on Vagrant and
Virtualbox.

## Usage
1. Clone this Repository
1. Copy the `configure/box.sample.yml` file to on of the following places:
    1. `../box.yml` (recommended if vbox is embedded (e.g. as a submodule) into a project)
    1. `box.yml` (recommended if vbox is used as a new and fresh git repo)
    1. `configure/box.yml` (recommended for development)
1. Adjust the setting in `box.yml`
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

WEB_ROOT: /var/www/html
SERVER_NAME: dev.box
USE_SSL: false
OPEN_BROWSER: true
```

### Additional synced folders
By default there is one folders synced to the vagrant box:
* ./ => /vagrant

If you want to sync additional folders, you can configure this in the`box.yml` file:
```yaml
folders:
  # Default web document root
  - host: ./src
    guest: /var/www/html
    owner: www-data
    group: www-data
```

### SSL
If SSL is enabled (`USE_SSL`) there will be two files created during provisioning:
* vbox.cert
* vbox.key
The CN of the created certificate will match `SERVER_NAME`.  
The created key and certificate will be used in Nginx and Apache. All traffic to http
is redirected to https.

The SSL files will not be versioned as this is generally not recommended for security
reasons.

### Additional OS packages installation
You can install additional OS packages before and/or after the whole provisioning
routine. This can be defined in box.yml, too.
```yaml
packages:
  preprovision:
    - unzip
      htop
  postprovision:
    # - supervisor
    #   tmux
```
This configuration will install unzip and htop before all other provisioning
scripts are executed. There will be no installation of packages in the postprovision
phase.

### Provisioning
In `box.yml` you can also configure which provisioning scripts should be executed:
```yaml
provision:
    php: true
    nginx: true
    apache: false
    nvm: false
    mysql: true
    docker: false
    welcome: true
    frameworks: false
    memcached: false
```

### Frameworks
If activated the following framework installers will be available:
* [Laravel](https://laravel.com/)
* [Lumen](https://lumen.laravel.com/)
* [Yii](https://www.yiiframework.com/)
* [Symfony](https://symfony.com/)

You can install the frameworks in the `src` folder by running:
```shell script
cd /var/www/html
laravel new <project-name>
# OR
$ lumen new <project-name>
#OR
$ yii-create <project-name>
# OR
$ symfony new <project-name> [--full]
```
**Note**
Make sure to change your webserver's config: `/etc/nginx/sites-available/default`
and set the correct document root.

## Services
* Nginx
* Apache (alternative to Nginx)
* PHP
* Composer
* NVM
  * Default NodeJS v12.14.1
  * Default NPM 6.13.4
* Docker
* Docker-Compose
* Mysql
* Memcached

## PHP
You can install different PHP versions at the same time.
```yaml
php:
  current: 7.2
  versions:
    - 7.2
    #- 7.3
    - 7.4
  modules:
    - curl
    - zip
    - common
    - json
    - mysql
    - readline
    - xml
    - gd
    - mbstring
    - opcache
    - sqlite3
    - intl
```
* `current` is the currently activated PHP version.
* `versions` is a list of PHP versions that are installed.
* `modules` contain all extra PHP modules that are installed.  
By default the FPM, CLI and xdebug modules are installed.

## Databases
Mysql settings and credentials are configured via `box.yml` as well:
```yaml
mysql:
  MYSQL_DATABASE: mydb
  MYSQL_ROOT_PASSWORD: root!
  MYSQL_USER_NAME: app
  MYSQL_USER_PASSWORD: app!
  MYSQL_MIGRATION_FILE: path/to/migration.sql
```

## Owner
* [ion2s GmbH](http://www.ion2s.com)
