#!/bin/sh
kubectl apply -f etcd.yaml
kubectl apply -f patroni.yaml