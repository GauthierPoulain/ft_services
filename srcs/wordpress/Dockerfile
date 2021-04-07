FROM alpine

RUN apk update

RUN apk add nginx
RUN apk add openrc
RUN apk add php
RUN apk add php7-fpm
RUN apk add php7-mysqli
RUN apk add php7-json

RUN mkdir -p /run/nginx
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN rc-status 2> /dev/null

WORKDIR /var/www/

RUN rm -rf *

COPY ./tmp/wordpress.tar.gz wordpress.tar.gz

RUN tar -xf wordpress.tar.gz
RUN rm -rf wordpress.tar.gz

RUN chmod 777 /var/www/wordpress

WORKDIR /

EXPOSE 80

COPY ./init.sh /init.sh

COPY ./default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT [ "sh", "init.sh" ]
