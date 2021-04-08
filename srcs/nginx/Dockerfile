FROM alpine:3.12.3

RUN apk update

RUN apk add nginx
RUN apk add openrc

RUN mkdir -p /run/nginx
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN rc-status 2> /dev/null

WORKDIR /

EXPOSE 80 443

COPY ./init.sh /init.sh

COPY ./default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT [ "sh", "init.sh" ]
