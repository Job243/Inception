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



# FROM debian:bullseye

# RUN apt-get update && apt-get install -y \
#     php zsh \
#     php-fpm \
#     php-mysql \
#     php-cli \
#     wget \
#     tar \
#     ca-certificates \
#     && rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /var/www/html

# RUN wget https://wordpress.org/latest.tar.gz \
#     && tar -xzf latest.tar.gz \
#     && rm -rf /var/www/html/* \
#     && mv wordpress/* /var/www/html/ \
#     && rm -rf wordpress latest.tar.gz

# COPY tools/wordpress.sh /wordpress.sh
# RUN chmod +x /wordpress.sh

# EXPOSE 9000

# ENTRYPOINT ["/wordpress.sh"]


# FROM debian:bullseye

# RUN apt update && apt install -y \
#     php7.4 php7.4-fpm php7.4-mysql \
#     curl mariadb-client

# # Forcer PHP-FPM à écouter sur 0.0.0.0:9000
# RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# RUN mkdir -p /run/php

# WORKDIR /var/www/html

# RUN curl -O https://wordpress.org/latest.tar.gz \
#     && tar -xzf latest.tar.gz --strip-components=1 \
#     && rm latest.tar.gz

# COPY tools/wordpress.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/wordpress.sh

# EXPOSE 9000

# ENTRYPOINT ["wordpress.sh"]
# CMD ["php-fpm7.4", "-F"]



# FROM debian:bullseye

# # Installer PHP et extensions + curl + mariadb-client
# RUN apt update && apt install -y \
#     php7.4 php7.4-fpm php7.4-mysql \
#     curl mariadb-client \
#     && rm -rf /var/lib/apt/lists/*

# # Créer le dossier pour PHP-FPM
# RUN mkdir -p /run/php

# WORKDIR /var/www/html

# # Télécharger WordPress
# RUN curl -O https://wordpress.org/latest.tar.gz \
#     && tar -xzf latest.tar.gz --strip-components=1 \
#     && rm latest.tar.gz

# # Copier le script d'initialisation
# COPY tools/wordpress.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/wordpress.sh

# # Configurer PHP-FPM pour écouter sur TCP 0.0.0.0:9000
# RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# # Exposer le port pour le container
# EXPOSE 9000

# # Entrypoint + CMD
# ENTRYPOINT ["wordpress.sh"]
# CMD ["php-fpm7.4", "-F"]


# FROM debian:bullseye

# RUN apt update && apt install -y \
#     php7.4 php7.4-fpm php7.4-mysql \
#     curl mariadb-client

# RUN mkdir -p /run/php

# WORKDIR /var/www/html

# RUN curl -O https://wordpress.org/latest.tar.gz \
#     && tar -xzf latest.tar.gz --strip-components=1 \
#     && rm latest.tar.gz

# COPY tools/wordpress.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/wordpress.sh

# EXPOSE 9000

# ENTRYPOINT ["wordpress.sh"]
# CMD ["php-fpm7.4", "-F"]

