FROM alpine:latest
LABEL maintainer="MODIN"
LABEL description="Docker Wordpress with NGINX + FPM"

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
ENV WORDPRESS ON

RUN apk add --update nginx && \
    apk add --no-cache \
    ${PHPMODULE} \
    supervisor \
    unzip wget  curl && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /tmp/nginx/ && \
    mkdir -p /usr/share/nginx/html

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN composer require opencensus/opencensus

COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY config/fpm/www.conf /etc/php7/php-fpm.d/www.conf
COPY config/session.php /opt/session.php
COPY script/starter.sh /starter.sh
COPY script/supervisord.conf /etc/supervisord.conf
COPY wp-config.php /opt/wp-config.php

ADD https://wordpress.org/latest.zip /opt/latest.zip

EXPOSE 80

ENTRYPOINT  ["sh", "/starter.sh"]
