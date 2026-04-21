#!/bin/bash
# Port-forward redis to localhost:6379
echo "Forwarding redis -> localhost:6379 (Ctrl+C to stop)"
kubectl port-forward svc/redis 6379:6379 -n dev
