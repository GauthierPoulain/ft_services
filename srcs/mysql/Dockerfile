FROM alpine:3.12.3

RUN apk update

RUN apk add openrc
RUN apk add mariadb
RUN apk add mariadb-client

RUN rc-status 2> /dev/null

RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf
RUN mkdir /etc/telegraf 
ADD srcs/telegraf.conf /etc/telegraf/

WORKDIR /

COPY ./srcs/init.sh /init.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "init.sh" ]