#!/bin/bash
clear
WP_DOWNLOADING_PATH=./srcs/wordpress/srcs/tmp
PMA_DOWNLOADING_PATH=./srcs/phpmyadmin/srcs/tmp

prepare() {
	minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-65535
	minikube addons enable metrics-server
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
	echo "downloading phpmyadmin..."
	mkdir -p $PMA_DOWNLOADING_PATH
	if ! [ -f $PMA_DOWNLOADING_PATH/phpMyAdmin-5.1.0-all-languages.zip ]; then
		curl -Lo $PMA_DOWNLOADING_PATH/phpMyAdmin-5.1.0-all-languages.zip https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip
	else
		echo "phpmyadmin already exist ($PMA_DOWNLOADING_PATH/phpMyAdmin-5.1.0-all-languages.zip)"
	fi
}

build() {
	docker build srcs/influxdb --rm -t ft-services-influxdb
	docker build srcs/wordpress --rm -t ft-services-wordpress
	docker build srcs/nginx --rm -t ft-services-nginx
	docker build srcs/mysql --rm -t ft-services-mysql
	docker build srcs/phpmyadmin --rm -t ft-services-phpmyadmin
	docker build srcs/grafana --rm -t ft-services-grafana
}

deploy() {
	kubectl apply -f ./srcs/metallb/namespace.yaml
	kubectl apply -f ./srcs/metallb/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f ./srcs/metallb/config.yaml
	kubectl apply -f ./srcs/influxdb/influxdb.yaml
	kubectl apply -f ./srcs/wordpress/wordpress.yaml
	kubectl apply -f ./srcs/nginx/nginx.yaml
	kubectl apply -f ./srcs/mysql/mysql.yaml
	kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
	kubectl apply -f ./srcs/grafana/grafana.yaml
}

prepare
build
deploy

echo "--------------------------------------------"
echo "nginx main page: http://$(minikube ip)"
echo "wordpress: http://$(minikube ip):5050 | http://$(minikube ip)/wordpress"
echo "phpmyadmin: http://$(minikube ip):5000 | http://$(minikube ip)/phpmyadmin"
echo "grafana: http://$(minikube ip):3000"
echo "--------------------------------------------"

minikube dashboard --url
