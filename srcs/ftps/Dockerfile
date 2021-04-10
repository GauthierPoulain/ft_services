FROM alpine:3.12.3
ARG IP

RUN apk update

RUN apk add openrc

RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf
RUN mkdir /etc/telegraf 
ADD srcs/telegraf.conf /etc/telegraf/

RUN mkdir -p /run/nginx
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN rc-status 2> /dev/null

RUN apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

RUN adduser -D "admin"
RUN echo "admin:admin" | chpasswd

RUN echo 'FTP of ft_services by tmarx' > /hello.txt

WORKDIR /

RUN echo ${IP} > ip.txt

ADD ./srcs/vsftpd.conf /etc/vsftpd/

COPY ./srcs/init.sh /init.sh

EXPOSE 21

ENTRYPOINT [ "sh", "init.sh" ]
