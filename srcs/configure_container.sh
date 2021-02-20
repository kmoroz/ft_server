openssl req -newkey rsa:2048 -x509 -sha256 -days 42 -nodes -out codam.crt -keyout codam.key -subj "/C=IE/ST=Leinster/L=Dublin/O=Codam/CN=codam"
mv codam.crt /etc/ssl/certs/
mv codam.key /etc/ssl/private/

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root
echo "UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

service php7.3-fpm start

nginx -g "daemon off;" 
echo "nginx is running like"




