FROM alpine:3.12.3

RUN apk update

RUN apk add influxdb

RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null