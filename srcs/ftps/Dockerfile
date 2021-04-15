FROM alpine:3.12.3

RUN apk update
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc telegraf
RUN mkdir /etc/telegraf 
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status 2> /dev/null
ADD srcs/telegraf.conf /etc/telegraf/


RUN mkdir -p /run/nginx

RUN apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

RUN adduser -D "admin"
RUN echo "admin:admin" | chpasswd 2>/dev/null

RUN echo 'FTP of ft_services by tmarx' > /hello.txt

WORKDIR /

ADD ./srcs/vsftpd.conf /etc/vsftpd/

ADD ./ip.txt /ip.txt

COPY ./srcs/init.sh /init.sh

EXPOSE 21

ENTRYPOINT [ "sh", "init.sh" ]
