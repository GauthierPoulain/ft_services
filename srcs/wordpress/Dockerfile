FROM alpine:3.12.3

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

COPY ./srcs/tmp/wordpress.tar.gz wordpress.tar.gz

RUN tar -xf wordpress.tar.gz
RUN rm -rf wordpress.tar.gz

RUN chmod 777 /var/www/wordpress

WORKDIR /

EXPOSE 80

COPY ./srcs/init.sh /init.sh

COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/wp-config.php /var/www/wordpress/wp-config.php

ENTRYPOINT [ "sh", "init.sh" ]
