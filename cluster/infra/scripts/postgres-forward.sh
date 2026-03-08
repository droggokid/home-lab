#!/bin/bash
# Port-forward postgres to localhost:5432
echo "Forwarding postgres -> localhost:5432 (Ctrl+C to stop)"
kubectl port-forward svc/postgres 5432:5432 -n dev
