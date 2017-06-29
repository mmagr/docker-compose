#!/bin/bash -x

# docker
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /tmp/docker.gpg
apt-key add /tmp/docker.gpg
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce

# docker compose
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# setup insecure registry
echo '{ "insecure-registries":["iotmid-docker.cpqd.com.br:5000"] }' | tee /etc/docker/daemon.json
service docker stop
service docker start
