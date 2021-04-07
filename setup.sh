#!/bin/bash
clear
minikube start --extra-config=apiserver.service-node-port-range=1-65535

metallb(){
	kubectl apply -f srcs/metallb/namespace.yaml
	kubectl apply -f srcs/metallb/metallb.yaml

	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f srcs/metallb/config.yaml
}

wordpress(){
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

nginx(){
	docker build srcs/nginx --rm -t ft-services-nginx
	kubectl apply -f srcs/nginx/nginx.yaml
}

run(){
	kubectl delete deployments --all
	kubectl delete services wordpress-service
	kubectl delete services nginx-service
	metallb
	nginx
	wordpress
	echo "ready to serve on $(minikube ip)"
}

eval $(minikube docker-env)

run &

minikube dashboard
