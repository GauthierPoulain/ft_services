FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

RUN apk add mariadb
RUN apk add mariadb-client

WORKDIR /

COPY ./srcs/init.sh /init.sh
COPY ./srcs/wordpress.sql /wordpress.sql

EXPOSE 3306

ENTRYPOINT [ "sh", "init.sh" ]