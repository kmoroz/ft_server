FROM debian:buster

COPY srcs ./srcs/

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get -y install openssl

#RUN apt-get -y install mariadb-server

RUN mkdir var/www/codam
RUN mv ./srcs/index.html var/www/codam
RUN mv ./srcs/nginx_config /etc/nginx/sites-available/codam

RUN ln -s /etc/nginx/sites-available/codam /etc/nginx/sites-enabled/codam
RUN rm -rf /etc/nginx/sites-enabled/default

CMD ./srcs/configure_container.sh