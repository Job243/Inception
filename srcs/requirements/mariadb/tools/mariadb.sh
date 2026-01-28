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


# #!/bin/bash
# set -e

# ROOT_PASS=$(cat /run/secrets/db_root_password)
# WP_PASS=$(cat /run/secrets/db_password)

# mkdir -p /run/mysqld
# chown -R mysql:mysql /run/mysqld
# chown -R mysql:mysql /var/lib/mysql

# # Init SEULEMENT si la base est vide
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     mysqld --user=mysql --bootstrap <<EOF
# USE mysql;

# ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';

# CREATE DATABASE wordpress;

# CREATE USER 'wp_user'@'%' IDENTIFIED BY '${WP_PASS}';
# GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

# FLUSH PRIVILEGES;
# EOF
# fi

# # Lancement NORMAL (foreground)
# exec mysqld --user=mysql


# #!/bin/bash
# set -e

# # Récupérer les secrets
# ROOT_PASS=$(cat /run/secrets/db_root_password)
# USER_PASS=$(cat /run/secrets/db_password)

# # Initialiser MariaDB seulement si la base est vide
# if [ !d "/var/lib/mysql/mysql" ]; then
#     mysqld --initialize-insecure --user=mysql
# fi

# # Lancer MariaDB en arrière-plan pour configurer les utilisateurs
# mysqld_safe --skip-networking &

# # Attendre que MariaDB soit prêt
# until mysqladmin ping >/dev/null 2>&1; do
#     sleep 1
# done

# # Configurer root et créer la DB utilisateur
# mysql -u root <<EOF
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';
# CREATE DATABASE IF NOT EXISTS wordpress;
# CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${USER_PASS}';
# GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'%';
# FLUSH PRIVILEGES;
# EOF

# # Stop temporaire de mysqld_safe
# mysqladmin -u root -p"${ROOT_PASS}" shutdown

# # Lancer MariaDB au premier plan (obligatoire pour Docker)
# exec mysqld_safe


# #!/bin/bash
# set -e

# ROOT_PASS=$(cat /run/secrets/db_root_password)
# USER_PASS=$(cat /run/secrets/db_password)

# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     echo "[INFO] Initialisation de MariaDB..."
#     mysqld --initialize-insecure --user=mysql

#     mysqld_safe --skip-networking &
#     pid="$!"

#     sleep 5

#     mysql -u root <<EOF
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
# CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${USER_PASS}';
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
# FLUSH PRIVILEGES;
# EOF

#     # Stop temporaire
#     mysqladmin -u root -p"${ROOT_PASS}" shutdown
#     wait "$pid"
# fi

# exec mysqld_safe



# #!/bin/sh

# set -e

# sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql

#     mysqld_safe --user=mysql &
#     # attendre que MariaDB soit prêt
#     until mysqladmin ping >/dev/null 2>&1; do
#       sleep 1
#     done

#     mysql << EOF
# CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
# CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
# FLUSH PRIVILEGES;
# EOF

#     mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
# fi

# exec mysqld_safe --user=mysql

