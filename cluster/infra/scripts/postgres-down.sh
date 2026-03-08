#!/bin/bash
# Scale postgres deployment down (to 0 replicas)
kubectl -n dev scale deploy/postgres --replicas=0
kubectl -n dev wait --for=delete pod -l app=postgres --timeout=60s
