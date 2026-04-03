# home-lab

Personal K3s homelab with ArgoCD GitOps.

## Services

- **Jellyfin** (apps): Media server - https://jellyfin.home.arpa
- **FileBrowser** (apps): File manager - https://filebrowser.home.arpa
- **Grafana** (monitoring): Dashboards - https://grafana.home.arpa
- **Temporal** (dev): Workflow engine - https://temporal.home.arpa
- **PostgreSQL** (dev): Database - postgres.dev.svc.cluster.local:5432

## Setup

```bash
# 1. Apply infrastructure
kubectl apply -f cluster/infra/

# 2. Create secrets (NEVER commit these!)
kubectl create secret generic postgres-credentials \
  --from-literal=POSTGRES_USER=postgres \
  --from-literal=POSTGRES_PASSWORD="$(openssl rand -base64 32)" \
  --from-literal=POSTGRES_DB=postgres -n dev

kubectl create secret generic temporal-postgres \
  --from-literal=POSTGRES_USER=postgres \
  --from-literal=POSTGRES_PWD="<same-password>" -n dev

kubectl create secret generic grafana-admin \
  --from-literal=username=admin \
  --from-literal=password="$(openssl rand -base64 32)" -n monitoring

# 3. Deploy with ArgoCD
kubectl apply -f cluster/apps/argo/
```

## Useful Commands

```bash
# Port forwarding
./cluster/infra/scripts/postgres-forward.sh
./cluster/infra/scripts/temporal-forward.sh

# Status
kubectl get pods -A
kubectl get applications -n argocd

# Logs
kubectl logs -f deployment/grafana -n monitoring
```

## Important Files

- `IMAGE_VERSIONS.md` - Container versions (pin, don't use :latest)
- `cluster/dev/postgres/SECRET_CREATION.md` - Database secret setup
- `cluster/.env.example` - FileBrowser credentials template

## Storage

All PVCs use `local-data` StorageClass (Rancher local-path):
- PostgreSQL: 10Gi
- Jellyfin: 20Gi + HostPath `/data/storage/files/media`
- FileBrowser: 20Gi + HostPath `/data/storage/files`
- VictoriaMetrics: 20Gi
- Grafana: 5Gi

Reclaim policy is **Retain** - manually delete PVs when done.

## Security

- Network policies: deny-all default, explicit allow rules
- All pods run as non-root with dropped capabilities
- Secrets created via kubectl (not in git)
- Self-signed TLS certs via cert-manager
