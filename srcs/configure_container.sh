openssl req -newkey rsa:2048 -x509 -sha256 -days 42 -nodes -out codam.crt -keyout codam.key -subj "/C=IE/ST=Leinster/L=Dublin/O=Codam/CN=codam"
mv codam.crt /etc/ssl/certs/
mv codam.key /etc/ssl/private/

nginx -g "daemon off;" 
echo "nginx is running like"




