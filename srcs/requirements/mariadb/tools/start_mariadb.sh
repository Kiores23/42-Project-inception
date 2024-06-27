#!/bin/sh
# replace env var in config file
chmod +x replace_env.sh && mv replace_env.sh $BIN/replace_env
replace_env /etc/my.cnf

# START AND SETUP MARIADB 
chown mysql:mysql $DB_PATH
mysql_install_db > /dev/null 2>&1
mysqld_safe > /dev/null 2>&1 &
echo "mysqld_safe starting..."
while ! mysqladmin ping --silent;
do
	sleep 1
done
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -e "CREATE USER IF NOT EXISTS $DB_USER@localhost IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY '$DB_PASS';"
mysql -e "FLUSH PRIVILEGES;"
echo mysqld_safe restarting...
# RESTART MARIADB
mysqladmin shutdown
echo "Mariadb works !"
mysqld_safe > /dev/null 2>&1
