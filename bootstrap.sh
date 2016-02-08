#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='password'
DATABASE='data'

# create public folder
sudo mkdir "/var/www/html/web"

# add repo for php5.6
sudo add-apt-repository ppa:ondrej/php

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install nginx and php
sudo apt-get install -y nginx php7.0 php7.0-fpm

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
sudo apt-get install php7.0-mysql
sudo mysql -uroot -p${PASSWORD} -e"CREATE DATABASE ${DATABASE};"

sudo rm /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/default

sudo cat >> /etc/nginx/sites-available/default <<'EOF'
server {
    listen       80;
    server_name  localhost;

    root  /var/www/html/web;
    index index.php;

    location / {
    try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
    try_files $uri =404;
    include fastcgi_params;
    fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    }
}
EOF

# add php info
sudo touch /var/www/html/web/info.php
sudo cat >> /var/www/html/web/info.php <<'EOF'
<?php phpinfo(); ?>
EOF

# restart nginx
service nginx restart
sudo service php7.0-fpm restart

# install git
sudo apt-get -y install git

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer