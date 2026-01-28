#!/bin/bash
set -e

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

cd /var/www/html

until mysqladmin ping -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
    echo "Waiting for database..."
    sleep 2
done

if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost=mariadb \
        --allow-root
fi

if ! wp core is-installed --allow-root 2>/dev/null; then
    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --allow-root
fi

chown -R www-data:www-data /var/www/html

exec "$@"



# #!/bin/bash
# set -e

# WORDPRESS_DB_USER="wp_user"
# WORDPRESS_DB_PASSWORD=$(cat /run/secrets/db_password)
# WORDPRESS_DB_NAME="wordpress"
# WORDPRESS_DB_HOST="mariadb"

# # Attendre la DB
# until php -r "
# \$link = @mysqli_connect(
#     '$WORDPRESS_DB_HOST',
#     '$WORDPRESS_DB_USER',
#     '$WORDPRESS_DB_PASSWORD',
#     '$WORDPRESS_DB_NAME'
# );
# if (!\$link) exit(1);
# "; do
#     echo "Waiting for database..."
#     sleep 2
# done

# # Config WordPress
# if [ ! -f /var/www/html/wp-config.php ]; then
#     cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

#     sed -i "s/database_name_here/$WORDPRESS_DB_NAME/" /var/www/html/wp-config.php
#     sed -i "s/username_here/$WORDPRESS_DB_USER/" /var/www/html/wp-config.php
#     sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/" /var/www/html/wp-config.php
#     sed -i "s/localhost/$WORDPRESS_DB_HOST/" /var/www/html/wp-config.php
# fi

# chown -R www-data:www-data /var/www/html

# exec php-fpm7.4 -F


# #!/bin/bash
# set -e

# # --- Récupérer les secrets Docker ---
# WORDPRESS_DB_USER="root"
# WORDPRESS_DB_PASSWORD=$(cat /run/secrets/db_password)
# WORDPRESS_DB_NAME="wordpress"
# WORDPRESS_DB_HOST="mariadb"

# # --- Attendre que la base de données soit disponible ---
# until php -r "
# \$link = @mysqli_connect('$WORDPRESS_DB_HOST', '$WORDPRESS_DB_USER', '$WORDPRESS_DB_PASSWORD', '$WORDPRESS_DB_NAME');
# if (!\$link) exit(1);
# " >/dev/null 2>&1; do
#     echo "Waiting for database..."
#     sleep 2
# done

# # --- Créer wp-config.php si nécessaire ---
# if [ ! -f /var/www/html/wp-config.php ]; then
#     cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

#     sed -i "s/database_name_here/$WORDPRESS_DB_NAME/" /var/www/html/wp-config.php
#     sed -i "s/username_here/$WORDPRESS_DB_USER/" /var/www/html/wp-config.php
#     sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/" /var/www/html/wp-config.php
#     sed -i "s/localhost/$WORDPRESS_DB_HOST/" /var/www/html/wp-config.php
# fi

# # --- Assurer les bons droits pour Nginx/PHP ---
# chown -R www-data:www-data /var/www/html

# # --- Lancer PHP-FPM au premier plan (obligatoire pour Docker et 42) ---
# exec php-fpm7.4 -F



# #!/bin/sh
# set -e

# # Attendre MariaDB
# echo "⏳ Waiting for MariaDB..."
# until mysqladmin ping -h mariadb -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
#     sleep 1
# done
# echo "✅ MariaDB is up!"

# # Générer wp-config.php si nécessaire
# if [ ! -f wp-config.php ]; then
# cat << EOF > wp-config.php
# <?php
# define('DB_NAME', '$WORDPRESS_DB_NAME');
# define('DB_USER', '$WORDPRESS_DB_USER');
# define('DB_PASSWORD', '$WORDPRESS_DB_PASSWORD');
# define('DB_HOST', 'mariadb');
# define('DB_CHARSET', 'utf8');
# define('DB_COLLATE', '');
# \$table_prefix = 'wp_';
# define('WP_DEBUG', false);
# if ( !defined('ABSPATH') )
#     define('ABSPATH', __DIR__ . '/');
# require_once ABSPATH . 'wp-settings.php';
# EOF
# fi

# exec php-fpm7.4 -F



# #!/bin/sh

# if [ ! -f wp-config.php ]; then
# cat << EOF > wp-config.php
# <?php
# define('DB_NAME', '$MYSQL_DATABASE');
# define('DB_USER', '$MYSQL_USER');
# define('DB_PASSWORD', '$MYSQL_PASSWORD');
# define('DB_HOST', 'mariadb');
# define('DB_CHARSET', 'utf8');
# define('DB_COLLATE', '');
# \$table_prefix = 'wp_';
# define('WP_DEBUG', false);
# if ( !defined('ABSPATH') )
#     define('ABSPATH', __DIR__ . '/');
# require_once ABSPATH . 'wp-settings.php';
# EOF
# fi

# exec "$@"
