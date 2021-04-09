FROM alpine:3.12.3

RUN apk update

RUN apk add openrc
RUN apk add nginx
RUN apk add php
RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype

RUN apk add phpmyadmin 2> /dev/null

RUN mkdir -p /run/nginx
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN mkdir -p /usr/share/webapps/phpmyadmin/tmp/
RUN chmod 777 /usr/share/webapps/phpmyadmin/tmp

RUN rc-status 2> /dev/null

WORKDIR /var/www/

RUN rm -rf *

WORKDIR /

COPY ./srcs/init.sh /init.sh

COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf

COPY ./srcs/config.inc.php /usr/share/webapps/phpmyadmin/config.inc.php

EXPOSE 5000

ENTRYPOINT [ "sh", "init.sh" ]
