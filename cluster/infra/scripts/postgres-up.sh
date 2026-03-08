#!/bin/bash
# Scale postgres deployment up (to 1 replica)
kubectl -n homelab-dev scale deploy/postgres --replicas=1
kubectl -n homelab-dev rollout status deploy/postgres
