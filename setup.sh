#!/bin/bash
RESET=0
export WP_PORT=5050

clear
read -n1 -p "do you want to reset minikube ? [y/N] " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	RESET=1
fi


if [ $RESET == 1 ]; then
	minikube stop
	minikube delete
fi
minikube start
eval $(minikube docker-env)

# metallb -------------------

if [ $RESET == 1 ]; then
	kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
fi
kubectl apply -f srcs/metallb/namespace.yaml
kubectl apply -f srcs/metallb/metallb.yaml
if [ $RESET == 1 ]; then
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
fi

# /metallb ------------------

# wordpress -----------------

echo "downloading wordpress..."
WP_DOWNLOADING_PATH=./srcs/wordpress/tmp/wordpress.tar.gz
if ! [ -f $WP_DOWNLOADING_PATH ]; then
	curl -Lo $WP_DOWNLOADING_PATH https://wordpress.org/latest.tar.gz
else 
	echo "wordpress already exist ($WP_DOWNLOADING_PATH)"
fi


docker build srcs/wordpress --rm -t ft-services-wordpress
echo "pushing wordpress image to minikube..."
minikube image load ft-services-wordpress
kubectl apply -f srcs/wordpress/wordpress.yaml

# /wordpress ----------------

minikube dashboard
