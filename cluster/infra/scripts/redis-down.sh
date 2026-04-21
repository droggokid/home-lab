#!/bin/bash
# Scale redis deployment down (to 0 replicas)
kubectl -n dev scale deploy/redis --replicas=0
kubectl -n dev wait --for=delete pod -l app=redis --timeout=60s
