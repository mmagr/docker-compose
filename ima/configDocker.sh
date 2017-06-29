#!/bin/bash -x 

# setup insecure registry
echo '{ "insecure-registries":["iotmid-docker.cpqd.com.br:5000"] }' | tee /etc/docker/daemon.json
service docker stop
service docker start

