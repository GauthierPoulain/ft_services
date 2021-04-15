FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc telegraf
RUN mkdir /etc/telegraf 
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null
ADD srcs/telegraf.conf /etc/telegraf/

RUN apk add nginx

RUN mkdir -p /run/nginx

WORKDIR /

COPY ./srcs/init.sh /init.sh

COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443 22

ENTRYPOINT [ "sh", "init.sh" ]
