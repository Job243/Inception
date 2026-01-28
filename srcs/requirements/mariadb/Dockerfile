FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
    chmod 777 /var/run/mysqld

COPY tools/mariadb.sh /mariadb.sh
RUN chmod +x /mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb.sh"]
CMD ["mysqld", "--user=mysql", "--bind-address=0.0.0.0"]


# FROM debian:bullseye

# RUN apt update && apt install -y mariadb-server zsh

# COPY tools/mariadb.sh /mariadb.sh
# RUN chmod +x /mariadb.sh

# ENTRYPOINT ["/mariadb.sh"]


# FROM debian:bullseye

# RUN apt update && apt install -y mariadb-server

# # 🔴 AJOUT CRITIQUE
# RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# COPY tools/mariadb.sh /usr/local/bin/mariadb.sh
# RUN chmod +x /usr/local/bin/mariadb.sh

# EXPOSE 3306

# ENTRYPOINT ["mariadb.sh"]
# CMD ["mysqld"]

