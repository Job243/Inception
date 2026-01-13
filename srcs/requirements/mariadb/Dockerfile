FROM debian:bookworm

RUN apt update && apt install -y \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
