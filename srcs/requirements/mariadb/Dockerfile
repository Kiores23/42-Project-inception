FROM alpine:3.19

RUN apk update && apk upgrade
RUN apk add --no-cache bash
RUN apk add --no-cache mariadb mariadb-client

COPY ./conf/my.cnf /etc/my.cnf
COPY tools/replace_env.sh .

COPY ./tools/start_mariadb.sh .
RUN chmod +x start_mariadb.sh

EXPOSE 3306
ENTRYPOINT ["./start_mariadb.sh"]
