FROM alpine:3.19

RUN apk update && apk upgrade
RUN apk add --no-cache wget
RUN apk add --no-cache sudo
RUN apk add --no-cache bash
RUN apk add --no-cache mariadb-client
RUN apk add --no-cache	php81 \
						php81-fpm \
						php81-mysqli \
						php81-phar \
						php81-mbstring

RUN ln -s /usr/bin/php81 /usr/bin/php
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY tools/replace_env.sh .

COPY ./tools/start_wordpress.sh .
RUN chmod +x ./start_wordpress.sh

EXPOSE 9000
ENTRYPOINT ["./start_wordpress.sh"]