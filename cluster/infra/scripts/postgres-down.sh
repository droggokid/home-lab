#!/bin/bash
# Scale postgres deployment down (to 0 replicas)
kubectl -n apps scale deploy/postgres --replicas=0
kubectl -n apps wait --for=delete pod -l app=postgres --timeout=60s
