FROM debian:buster

ENV	AUTOINDEX on

COPY srcs ./srcs/

RUN apt-get update
RUN apt-get -y install nginx && apt-get -y install openssl && apt-get -y install mariadb-server && apt-get install -y php7.3-fpm php-common php-mysql && apt-get install -y wget

RUN mkdir var/www/codam

#create autoindexing test files
RUN mkdir var/www/codam/anime && touch var/www/codam/anime/naruto.jpg

RUN mv ./srcs/web/* /var/www/codam/
RUN mv ./srcs/nginx_config /etc/nginx/sites-available/codam

RUN ln -s /etc/nginx/sites-available/codam /etc/nginx/sites-enabled/codam
#remove the default nginx file
RUN rm -rf /etc/nginx/sites-enabled/default

RUN mkdir var/www/codam/phpmyadmin
RUN mv ./srcs/config.inc.php var/www/codam/phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
#extract to phpmyadmin folder removing the first <1> components of the filename
RUN tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/codam/phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz
RUN mv /wordpress/ /var/www/codam/wordpress
RUN mv ./srcs/wp-config.php /var/www/codam/wordpress

#prefix with the location of the directory to download into
RUN wget -P ./tmp/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#to use WP-CLI from the command line by typing wp, 1. make the file executable and 
RUN chmod +x ./tmp/wp-cli.phar
#2. move it to somewhere in your PATH
RUN mv ./tmp/wp-cli.phar /usr/local/bin/wp

RUN chmod +x ./srcs/*.sh && ./srcs/setup_database.sh 

#change ownership of /var/www/* to a new user and group www-data 
#&& allow everyone to read and execute the file, the owner is allowed to write to the file as well
#&& make any script in srcs executable
RUN	chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/*

CMD ./srcs/toggle_autoindex.sh ${AUTOINDEX} && ./srcs/configure_container.sh