FROM debian:buster

COPY srcs ./srcs/

RUN apt-get update
RUN apt-get -y install nginx

#RUN apt-get -y install mariadb-server

RUN mv ./srcs/nginx_config /etc/nginx/sites-available/
RUN mkdir var/www/42_hogwarts
RUN mv ./srcs/index.html var/www/42_hogwarts

RUN ln -s /etc/nginx/sites-available/42_hogwarts /etc/nginx/sites-enabled/42_hogwarts

CMD ./srcs/configure_container.sh