#!/bin/bash -x

TARGET="/opt/deploy/$1"

[ -d "$TARGET" ] && rm -rf $TARGET

mkdir -p $TARGET
cd $TARGET
wget -O- "${2}" | tar zxf -

cd $TARGET/public
sed -i docker-compose.yml -e 's/iotmid-docker:5000/iotmid-docker.cpqd.com.br:5000/g'
docker-compose pull

