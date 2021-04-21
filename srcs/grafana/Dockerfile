FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null

RUN apk add grafana

ADD ./srcs/datasource.yaml /usr/share/grafana/conf/provisioning/datasources/
ADD ./srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/
ADD ./srcs/dashboards/*.json /usr/share/grafana/conf/provisioning/dashboards/

COPY ./srcs/init.sh /init.sh

WORKDIR /

EXPOSE 3000

ENTRYPOINT [ "sh", "init.sh" ]