# GitHub Copilot Instructions

This is a personal Kubernetes (K3s) homelab repository using GitOps with ArgoCD. It manages infrastructure, applications, monitoring, and development environment dotfiles.

## Repository Structure

### `cluster/` - Kubernetes Manifests

Organized by namespace with GitOps deployment via ArgoCD:

- **`apps/`** - User applications (Jellyfin media server, FileBrowser)
  - `argo/` - ArgoCD application definitions for automated sync
- **`dev/`** - Development tools (PostgreSQL, Temporal workflow engine, TicTac app)
- **`infra/`** - Infrastructure components (cert-manager, Traefik middleware, network policies, storage classes)
  - `scripts/` - Helper scripts for port-forwarding and scaling
- **`monitoring/`** - Observability stack (Grafana, VictoriaMetrics, node-exporter, kube-state-metrics)

### `dotfiles/` - Configuration Management

Desktop environment and development tools following XDG directory standards:

- **`git/`** - Git config with delta pager
- **`kube/`** - kubectl config (k3s-homelab cluster at 100.103.112.50)
- **`zsh/`** - Z Shell with Oh-My-Zsh + Powerlevel10k theme
- **`hypr/`** - Hyprland window manager
- **`kitty/`** - Terminal emulator
- **`nvim/`** - Neovim editor
- **`ssh/`** - SSH keys (gitignored)

### `shell/` - System Setup

Package lists for reproducible system installation:
- `apps-apt.txt` (265 packages)
- `apps-snap.txt`
- `apps-flatpak.txt`

### `gnome-backup/` - GNOME Desktop Backup

dconf settings export and restore scripts.

## Kubernetes Architecture

**Cluster**: K3s homelab  
**GitOps**: ArgoCD with auto-sync, prune, and self-heal enabled  
**Ingress**: Traefik with TLS certificates  
**Certificate Management**: cert-manager with self-signed ClusterIssuer (`homelab-selfsigned`)  
**Storage**: Rancher Local Path provisioner (`local-data` StorageClass) + HostPath mounts  
**Network Security**: NetworkPolicies with deny-all-default, explicit allow rules per app  
**Domain**: `.home.arpa` for all ingress hosts

### Namespaces

- `apps` - User applications
- `dev` - Development tools (resource quota: 4-8 CPU, 8-16Gi memory, 40 pods max)
- `monitoring` - Observability
- `argocd` - GitOps controller
- `cert-manager` - Certificate automation
- `kube-system` - Traefik ingress controller

## Working with This Repository

### Kubernetes Commands

```bash
# Verify ArgoCD sync status
kubectl get applications -n argocd

# Check application status
kubectl get pods -n apps
kubectl get pods -n dev
kubectl get pods -n monitoring

# View ingress routes
kubectl get ingress -A

# Check certificate status
kubectl get certificates -A
kubectl describe certificate <name> -n <namespace>
```

### Port Forwarding Scripts

Located in `cluster/infra/scripts/`:

```bash
# Forward PostgreSQL to localhost:5432
./cluster/infra/scripts/postgres-forward.sh

# Forward Temporal gRPC to localhost:7233
./cluster/infra/scripts/temporal-forward.sh

# Scale services up/down
./cluster/infra/scripts/postgres-up.sh    # Scale to 1 replica
./cluster/infra/scripts/postgres-down.sh  # Scale to 0 (pause)
./cluster/infra/scripts/temporal-up.sh
./cluster/infra/scripts/temporal-down.sh

# Reset FileBrowser admin password
./cluster/infra/scripts/admin-reset.sh
```

### Applying Manifest Changes

Changes are auto-deployed via ArgoCD when pushed to the `main` branch. For manual application:

```bash
# Apply single manifest
kubectl apply -f cluster/apps/jellyfin/jellyfin-deploy.yaml

# Apply directory recursively
kubectl apply -f cluster/monitoring/ -R

# Force ArgoCD sync
kubectl patch app <app-name> -n argocd -p '{"metadata": {"annotations": {"argocd.argoproj.io/refresh": "normal"}}}'
```

## Kubernetes Manifest Conventions

### File Naming

Pattern: `{app-name}-{resource-type}.yaml`

Examples:
- `jellyfin-deploy.yaml` - Deployment
- `jellyfin-service.yaml` - Service
- `jellyfin-ingress.yaml` - Ingress
- `jellyfin-pvc.yaml` - PersistentVolumeClaim
- `postgres-secret.yaml` - Secret

### Standard Metadata

```yaml
metadata:
  name: app-name
  namespace: apps  # or dev, monitoring, etc.
spec:
  revisionHistoryLimit: 2  # Keep only 2 old ReplicaSets
```

### Deployment Strategy

All single-replica apps use `Recreate` strategy (not RollingUpdate):

```yaml
spec:
  replicas: 1
  strategy:
    type: Recreate
```

### Health Checks

Include liveness and readiness probes for all containers:

```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
```

### Resource Specifications

Always define requests and limits:

```yaml
resources:
  requests:
    cpu: 100m
    memory: 256Mi
  limits:
    cpu: 500m
    memory: 1Gi
```

### GPU Resources

Jellyfin uses NVIDIA GPU:

```yaml
spec:
  runtimeClassName: nvidia
  containers:
    - resources:
        limits:
          nvidia.com/gpu: 1
```

### Persistent Storage

Use `local-data` StorageClass with WaitForFirstConsumer binding mode:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-data
  namespace: apps
spec:
  storageClassName: local-data
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

### Ingress Configuration

Standard pattern with Traefik + TLS:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  namespace: apps
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: websecure
    traefik.ingress.kubernetes.io/router.middlewares: kube-system-security-headers@kubernetescrd
    cert-manager.io/cluster-issuer: homelab-selfsigned
spec:
  tls:
    - hosts:
        - app.home.arpa
      secretName: app-tls
  rules:
    - host: app.home.arpa
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: app-service
                port:
                  number: 80
```

### Network Policies

Apps namespace uses deny-all-default. Each app requires explicit allow policy:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-myapp
  namespace: apps
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: kube-system
      ports:
        - protocol: TCP
          port: 8080
  egress:
    - to:
        - namespaceSelector:
            matchLabels:
              name: kube-system
        - podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: TCP
          port: 443
```

### Secret References

Never commit secrets to git. Use secret references in deployments:

```yaml
envFrom:
  - secretRef:
      name: app-credentials
```

Create secrets manually via kubectl (documented in a local `.env` file, not committed):

```bash
kubectl create secret generic app-credentials \
  --from-literal=USERNAME=admin \
  --from-literal=PASSWORD=secure-password \
  -n apps
```

### Init Containers for Dependencies

Use init containers to wait for dependent services:

```yaml
initContainers:
  - name: wait-for-postgres
    image: postgres:15-alpine
    command:
      - sh
      - -c
      - |
        until pg_isready -h postgres.dev.svc.cluster.local -p 5432 -U $POSTGRES_USER; do
          echo "Waiting for postgres...";
          sleep 2;
        done
    envFrom:
      - secretRef:
          name: postgres-credentials
```

## ArgoCD Application Pattern

Each namespace has an ArgoCD Application for automated sync:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: homelab-apps
  namespace: argocd
spec:
  project: homelab
  source:
    repoURL: https://github.com/droggokid/home-lab
    targetRevision: main
    path: cluster/apps
    directory:
      recurse: true
  destination:
    server: https://kubernetes.default.svc
    namespace: apps
  syncPolicy:
    automated:
      prune: true        # Delete resources removed from git
      selfHeal: true     # Revert manual changes
    syncOptions:
      - CreateNamespace=true
```

## Monitoring Stack

**VictoriaMetrics** scrapes:
- Self (port 8428)
- kube-state-metrics (port 8080)
- node-exporter (port 9100)
- Kubelet cadvisor (port 10250)

Scrape interval: 30s  
Metrics path: `/metrics`

**Grafana** datasource: VictoriaMetrics at `http://victoriametrics.monitoring.svc.cluster.local:8428`

## Traefik Middleware

Security headers middleware (`kube-system-security-headers`) applied to all ingress:

```yaml
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: security-headers
  namespace: kube-system
spec:
  headers:
    frameDeny: true
    sslRedirect: true
    browserXssFilter: true
    contentTypeNosniff: true
    stsIncludeSubdomains: true
    stsPreload: true
    stsSeconds: 31536000
```

## Deployed Applications

### Apps Namespace

- **Jellyfin** (`jellyfin.home.arpa`) - Media server with NVIDIA GPU, HostPath `/media/jellyfin`
- **FileBrowser** (`filebrowser.home.arpa`) - File manager with HostPath `/media/downloads`

### Dev Namespace

- **PostgreSQL** - Database on port 5432, PVC storage, credentials in `postgres-credentials` secret
- **Temporal** - Workflow orchestration (server + UI), depends on PostgreSQL
- **TicTac** - Custom application with ingress

### Monitoring Namespace

- **Grafana** (`grafana.home.arpa`) - Dashboarding with PVC
- **VictoriaMetrics** - Time-series database (Prometheus-compatible)
- **Node-Exporter** - DaemonSet for host metrics
- **Kube-State-Metrics** - Deployment for Kubernetes resource metrics

## Common Tasks

### Adding a New Application

1. Create manifests in `cluster/apps/{app-name}/`:
   - `{app}-deploy.yaml`
   - `{app}-service.yaml`
   - `{app}-ingress.yaml` (if external access needed)
   - `{app}-pvc.yaml` (if persistent storage needed)

2. Add NetworkPolicy in `cluster/infra/network-policies/allow-{app}.yaml`

3. Commit and push - ArgoCD will auto-sync

### Troubleshooting Ingress

```bash
# Check Traefik IngressRoute
kubectl get ingressroute -n kube-system

# View Traefik logs
kubectl logs -n kube-system -l app.kubernetes.io/name=traefik

# Check certificate status
kubectl describe certificate {app}-tls -n {namespace}
kubectl logs -n cert-manager -l app=cert-manager
```

### Debugging Network Policies

```bash
# Test connectivity from a pod
kubectl run -it --rm debug --image=nicolaka/netshoot -n apps -- bash

# Inside the pod:
curl http://service.namespace.svc.cluster.local:port
nslookup service.namespace.svc.cluster.local
```

### Accessing Services

All services accessible via:
- **Ingress**: `https://{app}.home.arpa` (requires DNS or `/etc/hosts` entry)
- **Port-forward**: Use scripts in `cluster/infra/scripts/`
- **NodePort**: Not used in this cluster

### Viewing Logs

```bash
# Stream logs from a pod
kubectl logs -f {pod-name} -n {namespace}

# View logs from all containers in a pod
kubectl logs {pod-name} -n {namespace} --all-containers=true

# Previous container logs (after restart)
kubectl logs {pod-name} -n {namespace} --previous
```

## Security Notes

- **Self-signed certificates**: All TLS uses self-signed CA from cert-manager ClusterIssuer
- **NetworkPolicies**: Deny-all-default in apps namespace, explicit allow rules required
- **Secret management**: Currently manual kubectl creation; secrets should never be committed to git
- **Resource quotas**: Dev namespace has limits to prevent resource exhaustion

## Dotfiles Management

Dotfiles use absolute paths with XDG base directories (`.config`). To apply:

```bash
# Example: Link Neovim config
ln -s ~/Github/home-lab/dotfiles/nvim/.config/nvim ~/.config/nvim

# Link all dotfiles (manual process, no automated script)
# Typically done for: git, zsh, hypr, kitty, kube
```
