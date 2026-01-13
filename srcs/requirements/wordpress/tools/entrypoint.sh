#!/bin/sh

sleep 5

if [ ! -f wp-config.php ]; then
	echo "Installing WordPress..."

	wp core download --allow-root

	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb:3306

	wp core install --allow-root \
		--url=https://localhost \
		--title="${WP_TITLE}" \
		--admin_user=${WP_ADMIN_USER} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL}

	wp user create --allow-root \
		${WP_USER} ${WP_USER_EMAIL} \
		--user_pass=${WP_USER_PASSWORD}
else
	echo "WordPress already installed."
fi

exec php-fpm8.2 -F
