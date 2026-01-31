# Developer Documentation — Inception

This document explains how a developer can set up, build, and maintain the Inception project.

---

## Prerequisites

The following tools are required:

- Docker
- Docker Compose
- Make

The project is designed to run on a Linux environment.

---

## Project configuration

- .env file contains all configuration values such as:
  - DOMAIN_NAME
  - WordPress settings (WP_TITLE, WP_ADMIN_USER, WP_USER, etc.)
  - Database settings (MYSQL_DATABASE, MYSQL_USER)
- Docker secrets are used to store sensitive data (database passwords)
- Each service (NGINX, WordPress, MariaDB) has its own Dockerfile

All containers are connected via a dedicated Docker network, ensuring isolation and secure communication.

---

## Build and launch the project

Clone the repository:
```bash
git clone https://github.com/Job243/Inception.git
cd Inception

make       # Build and start the containers
make stop  # Stop the containers
make clean # Remove containers, images, volumes and networks:

docker ps                                       # Check running containers
make logs                                       # View logs
docker container rm -f nginx wordpress mariadb  # Remove specific containers
docker volume rm srcs_wp srcs_db                # Remove volumes
docker system prune -af                         # Prune all unused Docker resources

