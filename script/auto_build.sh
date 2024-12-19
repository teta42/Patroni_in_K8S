#!/bin/sh
docker login

cd ../patroni

docker build -t teta42/patroni -f patroni.dockerfile .
docker push teta42/patroni