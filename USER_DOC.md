
---

# USER_DOC.md — version complète

```md
# User Documentation — Inception

This document explains how an end user or administrator can use the Inception project.

---

## Services provided by the stack

The project provides a full web stack:

- **NGINX**
  - Web server
  - Handles HTTPS using SSL/TLS
  - Serves the WordPress website

- **WordPress**
  - CMS for managing content
  - Allows creation of pages, posts, media, and users
  - Accessible via a web interface at `https://jmafueni.42.fr/wp-admin`

- **MariaDB**
  - Stores all WordPress data: users, posts, media, comments, and settings
  - Runs in a separate container

All services communicate through a private Docker network.

---

## Starting and stopping the project

Use the provided Makefile:

Start the project:
```bash

make       # Build and start the containers
make stop  # Stop the containers
make clean # Remove containers, images, volumes and networks
```
### Accessing the website and administration panel

- Website: https://jmafueni.42.fr
- WordPress admin: https://jmafueni.42.fr/wp-admin
- Default admin credentials:
- Username: superuser
- Email: admin@42.fr
- Default user credentials:
- Username: visitor
- Email: user@42.fr

### Checking services

```bash

- docker ps         # Check containers are running
- make logs         # Check logs     
- docker volume ls  # Ensure volumes exist
```

### Managing credentials

- WordPress credentials can be updated in the admin panel

- Database credentials are stored in Docker secrets

- .env file contains default configuration values