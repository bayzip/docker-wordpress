# Docker Wordpress
Docker for Wordpress build in with Nginx + PHP-FPM based on alpine images and supported with Redis session

[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/repository/docker/modinbah/wordpress_nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/modinbah/wordpress_nginx.svg)]()
[![Docker Stars](https://img.shields.io/docker/stars/modinbah/wordpress_nginx.svg)]()

## Informations

* Install [Docker](https://www.docker.com/)
* Install [Docker Compose](https://docs.docker.com/compose/install/)
* WP-Session [WP-Session](https://ethitter.com/plugins/wp-redis-user-session-storage/)

## Installation
Pull the image from the Docker repository.
```
docker pull modinbah/wordpress_nginx
```

## Running
You can running this wordpress using docker-compose (files provided in this repository):
```
docker-compose -f docker-compose.yml up -d
```
### Volume
We use the volume to make data not removed after shutdown docker-compose. You can change the volume from this configuration
```
# DATBASE
volume:
  - {YOUR_PATH}:/var/lib/mysql
    
# WORDPRESS
volume:
  - {YOUR_PATH}:/usr/share/nginx/html/
```

## Configuration
Using the docker compose, you can easy to run using the default configuration. If you want to change it, you can follow this instruction
### Database Configuration for Wp-Config
```
MYSQL_ROOT_PASSWORD 
MYSQL_DATABASE & DB_NAME
MYSQL_USER & DB_USER
MYSQL_PASSWORD & DB_PASSWORD
```
If you want to change value, you need to change both of environment. 

### PHP Module
In this configuration, we use PHP 7 as default version and PHP Module
- PHP FPM
- PHP opcache
- PHP curl
- PHP intl
- PHP iconv
- PHP mcrypt
- PHP bcmath
- PHP common
- PHP dev
- PHP gd
- PHP mbstring
- PHP mysqlnd
- PHP pdo
- PHP soap
- PHP xml
- PHP xmlrpc

If you want to change PHP Module or version, simple to add environment while you want running container from docker compose
```
PHPVERSION={YOUR_VERSION}
PHPMODULE="php${PHPVERSION} \
  php${PHPVERSION}-fpm \
  php${PHPVERSION}-{YOUR_MODULE}"
```

### WP-Session with Redis
By default, we use Redis as a session user login. If you have a concern and want to turn off, you can simply remove Redis from docker-compose, and change value to SESSION from ON to OFF.
```
SESSION=OFF
```
