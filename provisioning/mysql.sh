#!/usr/bin/env bash

# Mysql configuration
MYSQL_DATABASE=mydb
MYSQL_ROOT_PASSWORD=root!
MYSQL_USER_NAME=app
MYSQL_USER_PASSWORD=app!

debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"

apt-get install -y mysql-server

cp /vagrant/provisioning/configs/mysql/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Allow remote access for the root user
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "USE mysql; UPDATE user SET host='%' where user='root' and host='localhost';" > /dev/null 2>&1
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" > /dev/null 2>&1

# Create the database
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE database ${MYSQL_DATABASE};" > /dev/null 2>&1

# Create the application's user
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "USE mysql; CREATE USER '${MYSQL_USER_NAME}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';" > /dev/null 2>&1
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER_NAME}'@'localhost';" > /dev/null 2>&1
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" > /dev/null 2>&1

# Initial migration
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" < /vagrant/provisioning/migrations/00_initDB.sql


service mysql restart

exit $?
