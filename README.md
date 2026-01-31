*This project has been created as part of the 42 curriculum by jmafueni.*

# Inception

## Description

Inception is a system administration project focused on Docker and containerization.  
The goal of the project is to set up a small web infrastructure using Docker Compose, where each service runs in its own container.

The project includes a WordPress website served through NGINX over HTTPS, connected to a MariaDB database.  
All services are isolated, secured, and configured manually without using pre-built images.

This project aims to better understand how containers work, how services communicate together, and how to design a secure and persistent infrastructure.

---

## Services

The infrastructure is composed of three main containers:

- **NGINX**
  - Acts as the web server
  - Handles HTTPS using TLS
  - Redirects PHP requests to WordPress (PHP-FPM)

- **WordPress**
  - Runs with PHP-FPM
  - Hosts the WordPress website
  - Communicates with the database

- **MariaDB**
  - Stores all WordPress data
  - Uses a volume to persist data

Each container has its own Dockerfile and runs in the same Docker network.

---


## Resources

- Docker official documentation  
- Docker Compose documentation  
- NGINX documentation  
- WordPress documentation  
- MariaDB documentation  

### AI Usage

AI tools were used to help understand Docker concepts, debug configuration issues, and clarify infrastructure design choices.  
All configurations, scripts, and architectural decisions were implemented manually.


### Requirements

- Docker
- Docker Compose
- Make

### How to run the project

Clone the repository:
git clone https://github.com/Job243/Inception.git
cd Inception
```bash
make       # Build and start the containers
make stop  # Stop the containers
make clean # Remove containers, images, volumes and networks:
```


# Once everything is running, the website is available at:
https://jmafueni.42.fr



### Virtual Machines vs Docker

Virtual machines run a full operating system, which makes them heavier and slower.  
Docker containers share the host kernel, making them lightweight and faster to start.

Docker was chosen for its efficiency and ease of deployment.

---

### Secrets vs Environment Variables

Environment variables are easy to use but can expose sensitive information.  
Docker secrets provide a safer way to store credentials.

Secrets were used in this project to protect database passwords.

---

### Docker Network vs Host Network

Using the host network exposes services directly to the host system.  
A Docker network allows isolated and secure communication between containers.

A dedicated Docker network was used.

---

### Docker Volumes vs Bind Mounts

Bind mounts depend on the host filesystem and reduce portability.  
Docker volumes are managed by Docker and are better suited for persistent data.

Volumes were used for the database and WordPress files.
