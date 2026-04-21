#!/bin/bash
# Scale redis deployment up (to 1 replica)
kubectl -n dev scale deploy/redis --replicas=1
kubectl -n dev rollout status deploy/redis
