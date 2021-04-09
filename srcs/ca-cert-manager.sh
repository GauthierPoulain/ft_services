#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd $DIR
mkdir -p certs
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
  -subj "/C=FR/ST=Auvergne-Rhône-Alpes/L=Lyon/O=42/CN=gapoulai" \
  -keyout certs/tls.key -out certs/tls.cert

kubectl create secret tls ft-services-tls \
  --cert ./certs/tls.cert \
  --key ./certs/tls.key
