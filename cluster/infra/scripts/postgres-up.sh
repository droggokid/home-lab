#!/bin/bash
# Scale postgres deployment up (to 1 replica)
kubectl -n dev scale deploy/postgres --replicas=1
kubectl -n dev rollout status deploy/postgres
