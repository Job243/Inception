#!/bin/bash
set -e

ROOT_PASS=$(cat /run/secrets/db_root_password)
MYSQL_PASS=$(cat /run/secrets/db_password)

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysqld --user=mysql --bootstrap <<EOF
USE mysql;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF
fi

exec mysqld --user=mysql --bind-address=0.0.0.0
