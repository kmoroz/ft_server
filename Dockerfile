FROM debian:buster

ENV	AUTOINDEX on

COPY srcs ./srcs/

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get -y install openssl
RUN apt-get -y install mariadb-server
RUN apt-get install -y php7.3-fpm php-common php-mysql
RUN apt-get install -y wget

RUN mkdir var/www/codam

#create autoindexing test files
RUN mkdir var/www/codam/anime && touch var/www/codam/anime/naruto.jpg

RUN mv ./srcs/index.html /var/www/codam/
RUN mv ./srcs/styles.css /var/www/codam/
RUN mv ./srcs/ogre.svg /var/www/codam
RUN mv ./srcs/nginx_config /etc/nginx/sites-available/codam

RUN ln -s /etc/nginx/sites-available/codam /etc/nginx/sites-enabled/codam
RUN rm -rf /etc/nginx/sites-enabled/default

RUN mkdir var/www/codam/phpmyadmin
RUN mv ./srcs/config.inc.php var/www/codam/phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/codam/phpmyadmin

RUN wget -c https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz
RUN mv /wordpress/ /var/www/codam/wordpress
RUN mv ./srcs/wp-config.php /var/www/codam/wordpress

RUN wget -c -P ./tmp/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x ./tmp/wp-cli.phar
RUN mv ./tmp/wp-cli.phar /usr/local/bin/wp

RUN bash ./srcs/setup_database.sh

RUN service mysql start && \ 
wp core install --path='/var/www/codam/wordpress' --allow-root --url="/"  --title="Welcome to ft_shrek!" --admin_user="ksenia" --admin_password="12345678" --admin_email="root@gmail.com" && \
    mysql -e "USE wordpress;UPDATE wp_options SET option_value='https://localhost/wordpress' WHERE option_name='siteurl' OR option_name='home';"

RUN		chown -R www-data:www-data /var/www/*
RUN		chmod -R 755 /var/www/*
RUN     chmod +x ./srcs/*.sh

CMD ./srcs/toggle_autoindex.sh ${AUTOINDEX} && ./srcs/configure_container.sh