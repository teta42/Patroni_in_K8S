#!/bin/sh
kubectl apply -f etcd.yaml
cd aaa
kubectl apply -f sa.yaml
kubectl apply -f role.yaml
kubectl apply -f bind.yaml
cd ..
kubectl apply -f patroni.yaml
kubectl apply -f haproxy-dep.yaml
kubectl apply -f services.yaml