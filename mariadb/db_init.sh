#!/bin/bash

mysql_install_db --user=mysql
sleep 3
mysqld_safe &
sleep 3
#mysqladmin -u "$MARIADB_USER" password "$MARIADB_PASS"
mysql -e "use mysql; grant all privileges on *.* to '$MARIADB_USER'@'%' identified by '$MARIADB_PASS' with grant option;"
h=$(hostname)
mysql -e "use mysql; update user set password=password('$MARIADB_PASS') where user='$MARIADB_USER' and host='$h';"
mysql -e "flush privileges;"