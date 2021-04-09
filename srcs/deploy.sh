#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR

./restart.sh ./metallb/namespace.yaml
./restart.sh ./metallb/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
./restart.sh ./metallb/config.yaml
./restart.sh ./wordpress/wordpress.yaml
./restart.sh ./nginx/nginx.yaml
./restart.sh ./mysql/mysql.yaml
./restart.sh ./phpmyadmin/phpmyadmin.yaml