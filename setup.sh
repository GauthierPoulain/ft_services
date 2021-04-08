#!/bin/bash
clear

prepare()
{
	minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-65535
	eval $(minikube docker-env)
	minikube ssh "docker login -u gapoulai -p motdepassesupersafe"
	minikube ssh "docker pull metallb/controller:v0.9.6"
	minikube ssh "docker pull metallb/speaker:v0.9.6"
	minikube ssh "docker pull alpine:3.12.3"
	echo "downloading wordpress..."
	WP_DOWNLOADING_PATH=./srcs/wordpress/srcs/tmp
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
}

deploy(){
	kubectl apply -f srcs/metallb/namespace.yaml
	kubectl apply -f srcs/metallb/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f srcs/metallb/config.yaml
	kubectl apply -f srcs/wordpress/wordpress.yaml
	kubectl apply -f srcs/nginx/nginx.yaml
	kubectl apply -f srcs/mysql/mysql.yaml
}

prepare
build
deploy

echo "nginx main page: http://$(minikube ip)"
echo "wordpress: http://$(minikube ip):5050 | http://$(minikube ip)/wordpress"

minikube dashboard --url
