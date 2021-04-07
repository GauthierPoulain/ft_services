#!/bin/bash
clear

print_usage() {
  echo "usage :"
  echo "-r : reset minikube"
}

reset_minikube() {
	echo "minikube is cleaning up..."
	minikube stop
	minikube delete
	echo "minikube is clean"
}

while getopts 'r' flag; do
  case "${flag}" in
    r) reset_minikube ;;
    *) print_usage
       exit 1 ;;
  esac
done

minikube start
eval $(minikube docker-env)

# metallb -------------------

kubectl apply -f srcs/metallb/namespace.yaml
kubectl apply -f srcs/metallb/metallb.yaml

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"


# /metallb ------------------

# wordpress -----------------

echo "downloading wordpress..."
WP_DOWNLOADING_PATH=./srcs/wordpress/tmp
mkdir -p $WP_DOWNLOADING_PATH
if ! [ -f $WP_DOWNLOADING_PATH/wordpress.tar.gz ]; then
	curl -Lo $WP_DOWNLOADING_PATH/wordpress.tar.gz https://wordpress.org/latest.tar.gz
else 
	echo "wordpress already exist ($WP_DOWNLOADING_PATH/wordpress.tar.gz)"
fi


docker build srcs/wordpress --rm -t ft-services-wordpress
echo "pushing wordpress image to minikube..."
kubectl apply -f srcs/wordpress/wordpress.yaml

# /wordpress ----------------

kubectl apply -f srcs/metallb/config.yaml

minikube dashboard
