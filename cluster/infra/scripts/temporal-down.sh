#!/bin/bash
# Scale Temporal down (server + UI)
kubectl -n dev scale deploy/temporal --replicas=0
kubectl -n dev scale deploy/temporal-ui --replicas=0
kubectl -n dev wait --for=delete pod -l app=temporal --timeout=60s 2>/dev/null || true
kubectl -n dev wait --for=delete pod -l app=temporal-ui --timeout=60s 2>/dev/null || true
echo "Temporal is down. DB schema and data are preserved."
