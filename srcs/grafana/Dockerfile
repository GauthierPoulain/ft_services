FROM	alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk add grafana

COPY ./srcs/init.sh /init.sh

WORKDIR /

EXPOSE 3000

ENTRYPOINT [ "sh", "init.sh" ]