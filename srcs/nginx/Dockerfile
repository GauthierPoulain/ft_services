FROM alpine:3.12.3

RUN apk update

RUN apk add openrc
RUN apk add nginx

RUN mkdir -p /run/nginx
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN rc-status 2> /dev/null

WORKDIR /

COPY ./srcs/init.sh /init.sh

COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

ENTRYPOINT [ "sh", "init.sh" ]
