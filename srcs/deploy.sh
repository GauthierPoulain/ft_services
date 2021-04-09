#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR

apply()
{
	kubectl apply -f $1
}

apply ./metallb/namespace.yaml
apply ./metallb/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
apply ./metallb/config.yaml
apply ./wordpress/wordpress.yaml
apply ./nginx/nginx.yaml
apply ./mysql/mysql.yaml
apply ./phpmyadmin/phpmyadmin.yaml