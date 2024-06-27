#!/bin/sh

# replace env var in config file
chmod +x replace_env.sh && mv replace_env.sh $BIN/replace_env
replace_env /etc/php81/php-fpm.d/www.conf
# INSTALL WP
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1
chmod +x wp-cli.phar && mv wp-cli.phar $BIN/wp
# CREATE WP_FOLDER
mkdir -p /var/www && mkdir -p $WP_PATH
chown -R root:root $WP_PATH
# WAIT MARIADB
echo "Wait mariadb is alive..."
while ! mysqladmin -h mariadb -P $DB_PORT -u $DB_USER --password=$DB_PASS ping --silent;
do
	sleep 1
done
# SETUP WORDPRESS
wp cli update
if ! [ -f "$WP_PATH/wp-config.php" ]; then
	echo "Wordpress core download..."
	cd $WP_PATH && wp core download
	echo "wp-config.php creating..."
	sudo wp config create --allow-root \
						--dbname=$DB_NAME \
	    				--dbuser=$DB_USER \
						--dbpass=$DB_PASS \
						--dbhost=mariadb:$DB_PORT \
						--path=$WP_PATH
	echo "Installing WordPress..."
	sudo wp core install --allow-root \
					--url=$SITE_URL \
    				--title="$SITE_TITLE" \
    				--admin_user=$WP_ADMIN_USER \
    				--admin_password=$WP_ADMIN_PASSWORD \
    				--admin_email=$WP_ADMIN_EMAIL \
    				--path=$WP_PATH
else
	echo "wp-config.php already exists"
fi
echo "Wordpress works !"
php-fpm81 -F
