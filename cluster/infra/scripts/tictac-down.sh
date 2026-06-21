#!/bin/bash
# Scale tictac deployment down (to 0 replicas)
kubectl -n dev scale deploy/tictac-server --replicas=0
kubectl -n dev wait --for=delete pod -l app=tictac-server --timeout=60s
