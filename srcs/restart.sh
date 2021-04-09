#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR
eval $(minikube docker-env)
kubectl delete -f $1/$1.yaml
docker build ./$1 --rm -t ft-services-$1
kubectl apply -f $1/$1.yaml