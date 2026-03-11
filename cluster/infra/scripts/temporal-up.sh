#!/bin/bash
# Scale Temporal up (server + UI)
kubectl -n dev scale deploy/temporal --replicas=1
kubectl -n dev scale deploy/temporal-ui --replicas=1
kubectl -n dev rollout status deploy/temporal
kubectl -n dev rollout status deploy/temporal-ui
echo "Temporal is up. UI available at https://temporal.home.arpa"
