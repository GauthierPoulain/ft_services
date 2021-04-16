FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

RUN apk add influxdb

WORKDIR /

ADD ./srcs/influxdb.conf /etc/influxdb/influxdb.conf
ADD ./srcs/init.sh /init.sh

EXPOSE 8086

ENTRYPOINT [ "sh", "init.sh" ]