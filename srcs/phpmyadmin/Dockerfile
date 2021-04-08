FROM alpine:3.12.3

RUN apk update

RUN apk add openrc
RUN apk add nginx
RUN apk add php
RUN apk add php7-fpm
RUN apk add php7-mysqli
RUN apk add php7-json
RUN apk add unzip

RUN mkdir -p /run/nginx
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN rc-status 2> /dev/null

WORKDIR /var/www/

RUN rm -rf *

COPY ./srcs/tmp/phpMyAdmin-5.1.0-all-languages.zip phpMyAdmin-5.1.0-all-languages.zip

RUN unzip phpMyAdmin-5.1.0-all-languages.zip -d ./phpmyadmin
RUN rm -rf phpMyAdmin-5.1.0-all-languages.zip

RUN chmod 777 /var/www/phpmyadmin

WORKDIR /

COPY ./srcs/init.sh /init.sh

COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/wp-config.php /var/www/wordpress/wp-config.php

EXPOSE 80

ENTRYPOINT [ "sh", "init.sh" ]
