#!/bin/bash
# Port-forward websocket server for tictac -> localhost:8080
# Use this to connect workers/clients running on your local machine
echo "Forwarding tictac server -> localhost:8080 (Ctrl+C to stop)"
kubectl port-forward -n dev svc/tictac-server 8080:8080 --address=0.0.0.0
