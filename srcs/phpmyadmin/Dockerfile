FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc telegraf
RUN mkdir /etc/telegraf 
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null
ADD srcs/telegraf.conf /etc/telegraf/

RUN apk add php php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-session php7-mbstring

RUN apk add nginx

RUN apk add unzip

RUN mkdir -p /run/nginx

WORKDIR /var/www/

RUN rm -rf *

COPY ./srcs/tmp/phpMyAdmin-5.1.0-all-languages.zip ./phpMyAdmin-5.1.0-all-languages.zip

RUN unzip phpMyAdmin-5.1.0-all-languages.zip > /dev/null
RUN mv phpMyAdmin-5.1.0-all-languages phpmyadmin
RUN rm -rf phpMyAdmin-5.1.0-all-languages.zip

RUN mkdir -p /var/www/phpmyadmin/tmp/
RUN chmod 777 /var/www/phpmyadmin/tmp

WORKDIR /

COPY ./srcs/init.sh /init.sh

COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf

COPY ./srcs/config.inc.php /var/www/phpmyadmin/config.inc.php

EXPOSE 5000

ENTRYPOINT [ "sh", "init.sh" ]
