#!/bin/bash
clear
WP_DOWNLOADING_PATH=./srcs/wordpress/srcs/tmp

prepare()
{
	minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-65535
	eval $(minikube docker-env)
	minikube ssh "docker login -u gapoulai -p motdepassesupersafe"
	minikube ssh "docker pull metallb/controller:v0.9.6"
	minikube ssh "docker pull metallb/speaker:v0.9.6"
	minikube ssh "docker pull alpine:3.12.3"
	echo "downloading wordpress..."
	mkdir -p $WP_DOWNLOADING_PATH
	if ! [ -f $WP_DOWNLOADING_PATH/wordpress.tar.gz ]; then
		curl -Lo $WP_DOWNLOADING_PATH/wordpress.tar.gz https://wordpress.org/latest.tar.gz
	else
		echo "wordpress already exist ($WP_DOWNLOADING_PATH/wordpress.tar.gz)"
	fi
}

build()
{
	docker build srcs/wordpress --rm -t ft-services-wordpress
	docker build srcs/nginx --rm -t ft-services-nginx
	docker build srcs/mysql --rm -t ft-services-mysql
	docker build srcs/phpmyadmin --rm -t ft-services-phpmyadmin
}

prepare
build
./srcs/deploy.sh

echo "nginx main page: http://$(minikube ip)"
echo "wordpress: http://$(minikube ip):5050 | http://$(minikube ip)/wordpress"
echo "phpmyadmin: http://$(minikube ip):5000 | http://$(minikube ip)/phpmyadmin"

minikube dashboard --url
