FROM alpine:3.12.3

RUN apk update

RUN apk add influxdb

RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf
RUN mkdir /etc/telegraf 
ADD srcs/telegraf.conf /etc/telegraf/

WORKDIR /

ADD ./srcs/influxdb.conf /etc/influxdb/influxdb.conf
ADD ./srcs/init.sh /init.sh

EXPOSE 8086

ENTRYPOINT [ "sh", "init.sh" ]