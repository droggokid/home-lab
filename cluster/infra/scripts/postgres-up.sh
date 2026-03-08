#!/bin/bash
# Scale postgres deployment up (to 1 replica)
kubectl -n apps scale deploy/postgres --replicas=1
kubectl -n apps rollout status deploy/postgres
