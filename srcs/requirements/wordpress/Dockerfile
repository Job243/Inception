FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-mysqli \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    wget \
    curl \
    mariadb-client \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's|;listen.owner = www-data|listen.owner = www-data|g' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's|;listen.group = www-data|listen.group = www-data|g' /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html

RUN wget --no-check-certificate https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz && \
    chown -R www-data:www-data /var/www/html

RUN wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/wordpress.sh"]
CMD ["php-fpm7.4", "-F"]

# docker exec -it mariadb mysql -u root -p
# USE wordpress;
# UPDATE wp_options;
# SET option_value = 'https://localhost'
# WHERE option_name IN ('siteurl', 'home');

