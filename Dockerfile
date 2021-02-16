FROM debian:buster

COPY srcs ./srcs/

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server