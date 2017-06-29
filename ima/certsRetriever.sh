#!/bin/bash -x

apt-get update
apt-get install -y software-properties-common


apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:certbot/certbot
apt-get update
apt-get install -y certbot


cn="$(hostname).ima.sp.gov.br"
certbot register -m "$1" --no-eff-email --agree-tos
certbot certonly --standalone -d "$cn"

