FROM debian:buster

COPY srcs ./srcs/

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get -y install openssl
RUN apt-get -y install mariadb-server
RUN apt-get install -y php7.3-fpm php-common php-mysql
RUN apt-get install -y wget

RUN mkdir var/www/codam
RUN echo "<?php phpinfo(); ?>" >> /var/www/codam/index.php
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

CMD ./srcs/configure_container.sh