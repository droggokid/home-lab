#!/bin/bash
# Scale tictac deployment up (to 1 replica)
kubectl -n dev scale deploy/tictac-server --replicas=1
kubectl -n dev rollout status deploy/tictac-server
