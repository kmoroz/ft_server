service mysql start

# Configure a wordpress database
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'ksenia'@'localhost';" | mysql -u root
echo "SET PASSWORD FOR 'ksenia'@'localhost' = PASSWORD('12345678');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'ksenia'@'localhost' IDENTIFIED BY '12345678';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
