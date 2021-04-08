#!/bin/bash
clear

minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-65535

eval $(minikube docker-env)
minikube ssh "docker login -u gapoulai -p motdepassesupersafe"

metallb() {
	kubectl apply -f srcs/metallb/namespace.yaml
	kubectl apply -f srcs/metallb/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f srcs/metallb/config.yaml
}

wordpress() {
	echo "downloading wordpress..."
	WP_DOWNLOADING_PATH=./srcs/wordpress/tmp
	mkdir -p $WP_DOWNLOADING_PATH
	if ! [ -f $WP_DOWNLOADING_PATH/wordpress.tar.gz ]; then
		curl -Lo $WP_DOWNLOADING_PATH/wordpress.tar.gz https://wordpress.org/latest.tar.gz
	else
		echo "wordpress already exist ($WP_DOWNLOADING_PATH/wordpress.tar.gz)"
	fi

	docker build srcs/wordpress --rm -t ft-services-wordpress
	kubectl apply -f srcs/wordpress/wordpress.yaml
}

nginx() {
	docker build srcs/nginx --rm -t ft-services-nginx
	kubectl apply -f srcs/nginx/nginx.yaml
}

pull_images() {
	minikube ssh "docker pull metallb/controller:v0.9.6"
	minikube ssh "docker pull metallb/speaker:v0.9.6"
	minikube ssh "docker pull alpine:3.12.3"
}

run() {
	pull_images
	metallb
	nginx
	wordpress
	echo "ready to serve on $(minikube ip)"
}

run

minikube dashboard
