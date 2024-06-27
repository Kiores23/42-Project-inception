FROM alpine:3.19

RUN apk update && apk upgrade
RUN apk add --no-cache bash
RUN apk add --no-cache nginx
RUN apk add --no-cache openssl

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/replace_env.sh .

COPY tools/start_nginx.sh .
RUN chmod +x start_nginx.sh

CMD ["./start_nginx.sh"]