#!/bin/bash

# Optimization Configuration Based on Container Core
procs=$(cat /proc/cpuinfo | grep processor | wc -l)
sed -i -e "s/worker_processes auto/worker_processes $procs/" /etc/nginx/nginx.conf

cd /usr/share/nginx/html/ 

if [ $WORDPRESS == ON ]; then
    echo "Instaling Wordpress"
    if [ ! -d /usr/share/nginx/html/wp-config.php ]; then
        if [ ! -f /opt/latest.zip ]; then
            wget https://wordpress.org/latest.zip
        fi
        cp /opt/latest.zip /usr/share/nginx/html/latest.zip
        unzip latest.zip
        mv wordpress/* .
        rm -rf wordpress
        cp /opt/wp-config.php /usr/share/nginx/html/wp-config.php
        sed -i "s/database_name_here/$DB_NAME/" /usr/share/nginx/html/wp-config.php
        sed -i "s/username_here/$DB_USER/" /usr/share/nginx/html/wp-config.php
        sed -i "s/password_here/$DB_PASSWORD/" /usr/share/nginx/html/wp-config.php
        sed -i "s/localhost/$DB_HOST/" /usr/share/nginx/html/wp-config.php
        chown -R nginx:nginx /usr/share/nginx/html
    else
        echo "Wordpress telah terinstall"
    fi
else
    echo "Skip Installing Wordpress"
fi

if [ $SESSION == ON ]; then
    echo "Installing Session Pluggin WP"
    if [ ! -d  /usr/share/nginx/html/wp-content/mu-plugins ]; then
        cd wp-content
        mkdir mu-plugins
        mv /opt/session.php /usr/share/nginx/html/wp-content/mu-plugins 
        chown -R nginx:nginx /usr/share/nginx/html/wp-content/
        sed -i "s/wpruss/$PREFIX_SESSION/" /usr/share/nginx/html/wp-content/mu-plugins/session.php
        sed -i "s/127.0.0.1/$SESSION_HOST/" /usr/share/nginx/html/wp-content/mu-plugins/session.php
    else
        echo "Session telah terinstall"
    fi
else
    echo "Session OFF"
fi

/usr/bin/supervisord -n -c /etc/supervisord.conf