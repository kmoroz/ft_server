#!/bin/bash

service mysql start

# Configure a wordpress database
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'ksenia'@'localhost';" | mysql -u root
echo "SET PASSWORD FOR 'ksenia'@'localhost' = PASSWORD('12345678');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'ksenia'@'localhost' IDENTIFIED BY '12345678';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

wp core install --path='/var/www/codam/wordpress' --allow-root --url="/"  --title="Welcome to ft_shrek!" --admin_user="ksenia" --admin_password="12345678" --admin_email="root@gmail.com" && \
    mysql -e "USE wordpress;UPDATE wp_options SET option_value='https://localhost/wordpress' WHERE option_name='siteurl' OR option_name='home';"
