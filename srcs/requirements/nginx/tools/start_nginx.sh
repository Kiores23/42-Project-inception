#!/bin/sh
# replace env var in config file
chmod +x replace_env.sh && mv replace_env.sh $BIN/replace_env
replace_env /etc/nginx/nginx.conf
# CREATE SSL KEY
mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=amery.42.fr/UID=amery" > /dev/null 2>&1
echo "Nginx works !"
nginx -g 'daemon off;'
