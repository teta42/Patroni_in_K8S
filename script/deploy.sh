#!/bin/sh
cd ../manifest

kubectl apply -f etcd.yaml
kubectl apply -f patroni.yaml