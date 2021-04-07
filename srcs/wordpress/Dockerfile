FROM alpine:latest

RUN apk update
RUN apk upgrade

RUN apk add apache2
RUN apk add php7
RUN apk add php7-fpm
RUN apk add php7-opcache
RUN apk add php7-gd
RUN apk add php7-mysqli
RUN apk add php7-zlib
RUN apk add php7-curl

WORKDIR /var/www/

RUN rm -rf *

COPY ./tmp/wordpress.tar.gz wordpress.tar.gz

RUN tar -xf wordpress.tar.gz
RUN rm -rf wordpress.tar.gz

RUN mv wordpress html

WORKDIR /

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]