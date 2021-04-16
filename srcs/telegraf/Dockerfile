FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf
RUN mkdir /etc/telegraf 
ADD srcs/telegraf.conf /etc/telegraf/

WORKDIR /

COPY ./srcs/init.sh /init.sh

ENTRYPOINT [ "sh", "init.sh" ]
