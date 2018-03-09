#!/usr/bin/env bash

########### START EDITING HERE ###########

PASSWORD='password'
DATABASE='database'

########### STOP EDITING HERE ###########

# create public folder
sudo mkdir "/var/www/html/web"

# add repo for php7
sudo add-apt-repository ppa:ondrej/php

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install nginx and php
sudo apt-get install -y nginx php7.2 php7.2-fpm php7.2-zip php7.2-xml php7.2-mbstring php7.2-gd

# install mysql and give password to installer
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password $PASSWORD'
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password $PASSWORD'
sudo apt-get -y install mysql-server-5.7
sudo apt-get install php7.2-mysql
sudo mysql -uroot -p${PASSWORD} -e"CREATE DATABASE ${DATABASE};"

sudo rm /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/default

sudo cat >> /etc/nginx/sites-available/default <<'EOF'
server {
    listen       80;
    server_name  localhost;

    root  /var/www/html/web;
    index index.php;

    sendfile off;
    client_max_body_size 8M;

    location / {
    try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
    try_files $uri =404;
    include fastcgi.conf;
    fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    }
}
EOF

# restart nginx
service nginx restart
sudo service php7.2-fpm restart

# install git
sudo apt-get -y install git

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# add Composer vendor bin directory to PATH
sudo echo 'PATH=$PATH:/home/vagrant/.config/composer/vendor/bin' >> /home/vagrant/.bashrc
