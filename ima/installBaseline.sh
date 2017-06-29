#!/bin/bash -x

TARGET="/opt/deploy/$1"

[ -d "$TARGET" ] && rm -rf $TARGET

mkdir -p $TARGET
cd $TARGET
wget -O- "${2}" | tar zxf -

cd $TARGET/public
docker-compose pull

