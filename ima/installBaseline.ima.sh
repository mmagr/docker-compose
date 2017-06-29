#!/bin/bash -x

TARGET="/opt/deploy/$1"

[ -d "$TARGET" ] && rm -rf $TARGET

mkdir -p $TARGET
cd $TARGET
tar zxf $2

cd $TARGET/public
docker-compose pull

