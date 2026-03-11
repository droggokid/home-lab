#!/bin/bash
# Port-forward Temporal gRPC frontend -> localhost:7233
# Use this to connect workers/clients running on your local machine
echo "Forwarding Temporal gRPC -> localhost:7233 (Ctrl+C to stop)"
kubectl port-forward svc/temporal-frontend 7233:7233 -n dev
