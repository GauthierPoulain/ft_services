FROM debian:buster

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install apache2 -y

RUN apt-get install libapache2-mod-php -y
RUN apt-get install php-mysql -y

WORKDIR /var/www/

RUN rm -rf *

COPY ./tmp/wordpress.tar.gz wordpress.tar.gz

RUN tar -xf wordpress.tar.gz
RUN rm -rf wordpress.tar.gz

RUN mv wordpress html

WORKDIR /

CMD apachectl -D FOREGROUND