
#displat the linux type in use
lsb_release -a

# Update package index
sudo apt update

# Install Apache
sudo apt install -y apache2

# Install MySQL and secure installation
sudo apt install -y mysql-server

# Install PHP and required modules
sudo apt install -y php

# Restart Apache
sudo systemctl restart apache2

# Start Apache
sudo systemctl start apache2

# Enable Apache to start on boot
sudo systemctl enable apache2

# Enable Apache extensions for php
sudo apt install php libapache2-mod-php -y

# enable phpinfo page
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/phpinfo.php

# Restart Apache
sudo systemctl restart apache2

echo "LAMP stack installation completed."


#! /bin/bash

# clone the repo
git clone https://github.com/laravel/laravel

# enter into the repo
cd laravel

# rename .env 
mv .env.example .env

# install composer dependencies
sudo apt-get install php-xml php-curl -y
sudo apt install php-cli php-json php-common curl php-mbstring php-zip unzip zip unzip php-curl php-xml -y
sleep 5

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# update the repo
composer install

# update the repo
composer update


# generate app key
php artisan key:generate


# disable the default apache page
sudo a2dissite 000-default.conf

# navigate to sites-availble
cd /etc/apache2/sites-available



# create your site file
sudo touch laravel.conf

# update the content
sudo sed -n 'w laravel.conf' <<EOF
<VirtualHost *:80>
    ServerAdmin uneku@ejig.com
    ServerName laravel.local

    DocumentRoot /var/www/laravel/public

    <Directory /var/www/laravel/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/laravel-error.log
    CustomLog \${APACHE_LOG_DIR}/laravel-access.log combined

    <IfModule mod_dir.c>
        DirectoryIndex index.php
    </IfModule>
</VirtualHost>
EOF


# enable the site
sudo a2ensite laravel

# create the site directory
sudo mkdir -p /var/www/laravel

# copy the content to site directory
cd /home/vagrant
sudo cp -r laravel/. /var/www/laravel/

# go back to the directory
cd /var/www/laravel

# set permission for the files
sudo chown -R vagrant:www-data /var/www/laravel/
sudo find /var/www/laravel/ -type f -exec chmod 664 {} \;
sudo find /var/www/laravel/ -type d -exec chmod 775 {} \;
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache

# reload apache
sudo systemctl reload apache2


