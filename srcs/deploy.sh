#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR
restart(){
	kubectl apply -f $1
}

restart ./metallb/namespace.yaml
restart ./metallb/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
restart ./metallb/config.yaml
restart ./wordpress/wordpress.yaml
restart ./nginx/nginx.yaml
restart ./mysql/mysql.yaml
restart ./phpmyadmin/phpmyadmin.yaml