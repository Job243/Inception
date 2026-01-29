FROM debian:bullseye

RUN apt update && apt install -y nginx openssl zsh

RUN openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx.key \
  -out /etc/ssl/certs/nginx.crt \
  -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jmafueni.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
