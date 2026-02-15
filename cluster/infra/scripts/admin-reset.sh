#!/bin/bash
# remember to change NEWPASS
kubectl -n apps scale deploy/filebrowser --replicas=0
kubectl -n apps wait --for=delete pod -l app=filebrowser --timeout=60s

cat <<'YAML' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: fb-admin
  namespace: apps
spec:
  restartPolicy: Never
  containers:
  - name: fb-admin
    image: filebrowser/filebrowser:latest
    command: ["filebrowser"]
    args: ["users","update","admin","--password","NEWPASS","--database","/database/filebrowser.db"]
    volumeMounts:
    - name: data
      mountPath: /database
      subPath: database
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: filebrowser-data
YAML

kubectl -n apps logs -f fb-admin
kubectl -n apps delete pod fb-admin
kubectl -n apps scale deploy/filebrowser --replicas=1
