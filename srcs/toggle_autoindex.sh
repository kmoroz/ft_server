#!/bin/bash

if [ "$1" = "off" ]; then
	sed -i "s/autoindex on/autoindex off/g" /etc/nginx/sites-available/codam
	echo "autoindex off"
elif [ "$1" = "on" ]; then
	sed -i "s/autoindex off/autoindex on/g" /etc/nginx/sites-available/codam
	echo "autoindex on"
fi

if [ -e /var/run/nginx.pid ]; then 
	nginx -s reload;
	echo "nginx reloaded"
fi
