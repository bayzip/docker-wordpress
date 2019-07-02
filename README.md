# nginx-fpm-docker
Docker image for NGINX + PHP-FPM based on alpine images with auto install wordpress

## NGINX Port
Default Open Port is 80, if you want to change open port add to environment like this
```
--env PORT_NGINX="PORT NUMBER"
or
-e PORT_NGINX="PORT NUMBER"
```

## Wordpress Installation
Default for WordPress installation is on, but if you has been installed WordPress you can simply turn off this environment and skip DB configuration for WordPress.
```
--env WORDPRESS "ON/OFF"
or
-e WORDPRESS "ON/OFF"
```

### Database Configuration for Wp-Config
```
--env MYSQL_ROOTPW RootPWDatabase100@
--env MYSQL_DB wordpress
--env MYSQL_USER userDB
--env MYSQL_USER_PW userDBPass100@
or
-e MYSQL_ROOTPW RootPWDatabase100@
-e MYSQL_DB wordpress
-e MYSQL_USER userDB
-e MYSQL_USER_PW userDBPass100@
```

### WP-Session with Redis
If you want to use session user every user login and log out to improve speed, you can simply run this environment.
```
--env SESSION ON/OFF
--env PREFIX_SESSION wpuser
--env SESSION_HOST wp_redis
or
--e SESSION ON/OFF
--e PREFIX_SESSION wpuser
--e SESSION_HOST wp_redis
```

## PHP Version
Default PHP using PHP 7. If you want to change default PHP simple to add environment like this
```
--env PHPVERSION "Version"
or
-e PHPVERSION "Version"
```

## PHP Module
Default Module PHP
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

If you want to change PHP Module, simple to add environment while you running container.
```
--env PHPMODULE=php${PHPVERSION} \
--env PHPMODULE=php${PHPVERSION}-"Module"
or
-e PHPMODULE=php${PHPVERSION} \
-e PHPMODULE=php${PHPVERSION}-"Module" 
```

