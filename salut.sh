	kubectl delete -f ./srcs/metallb/namespace.yaml
	kubectl delete -f ./srcs/metallb/metallb.yaml
	kubectl delete -f ./srcs/metallb/config.yaml
	kubectl delete -f ./srcs/nginx/nginx.yaml

	kubectl apply -f ./srcs/metallb/namespace.yaml
	kubectl apply -f ./srcs/metallb/metallb.yaml
	kubectl apply -f ./srcs/metallb/config.yaml
	kubectl apply -f ./srcs/nginx/nginx.yaml