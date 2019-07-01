FROM alpine:latest
LABEL maintainer="Bayu Adin H <bayu.adin.h@mail.ugm.ac.id>"
LABEL description="Docker with NGINX + FPM"

ENV PHPVERSION 7
ENV PHPMODULE="php${PHPVERSION} \
    php${PHPVERSION}-fpm \
	php${PHPVERSION}-redis \
    php${PHPVERSION}-opcache \
    php${PHPVERSION}-curl \
    php${PHPVERSION}-intl \
    php${PHPVERSION}-iconv \
    php${PHPVERSION}-mcrypt  \
    php${PHPVERSION}-bcmath \
    php${PHPVERSION}-common \
    php${PHPVERSION}-dev \
    php${PHPVERSION}-gd \
    php${PHPVERSION}-mbstring \
    php${PHPVERSION}-mysqlnd \
    php${PHPVERSION}-mysqli \
    php${PHPVERSION}-pdo \
    php${PHPVERSION}-soap \
    php${PHPVERSION}-xml \
    php${PHPVERSION}-xmlrpc"
ENV PORT_NGINX 80
ENV WORDPRESS ON
ENV DB_NAME dbwordpress
ENV DB_USER wpuser_wordpress
ENV DB_PASSWORD passWordPress
ENV DB_HOST wp_mariadb
ENV SESSION ON
ENV PREFIX_SESSION wpuser
ENV SESSION_HOST wp_redis

RUN apk add --update nginx && \
    apk add --no-cache \
    ${PHPMODULE} \
    supervisor \
    unzip \
    wget \
    curl && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /tmp/nginx/ && \
    mkdir -p /usr/share/nginx/html

COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY config/fpm/www.conf /etc/php7/php-fpm.d/www.conf
COPY config/session.php /opt/session.php
COPY script/starter.sh /starter.sh
COPY script/supervisord.conf /etc/supervisord.conf
ADD https://wordpress.org/latest.zip /opt/latest.zip

EXPOSE ${PORT_NGINX}/tcp

ENTRYPOINT  ["sh", "/starter.sh"]