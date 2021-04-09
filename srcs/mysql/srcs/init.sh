/etc/init.d/mariadb setup
service mariadb start

mysql -u root -e "create user '${MYSQL_ROOT_USERNAME}'@'%' identified by '${MYSQL_ROOT_PASSWORD}'"
mysql -u root -e "create database wordpress"
mysql -u root -e "grant all privileges on *.* to '${MYSQL_ROOT_USERNAME}'@'%'"
mysql -u root -e "flush privileges"
mysql -u root -e "exit"
sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
service mariadb restart

while [ $(/usr/bin/pgrep mysql | wc -l) -gt 0 ]; do
	sleep 2
done
