# Container Image Versions

This file tracks all container images used in the homelab cluster. Always use specific version tags for reproducibility and security.

## Update Process

1. Check for new versions at the respective project repositories
2. Test in a non-production environment first
3. Update this file and corresponding manifests
4. Commit and push - ArgoCD will auto-sync

## Current Versions

Last updated: 2026-04-02

### Applications (apps namespace)

| Service | Image | Version | Notes |
|---------|-------|---------|-------|
| FileBrowser | `filebrowser/filebrowser` | `v2.31.2` | File management interface |
| Jellyfin | `jellyfin/jellyfin` | `10.9.11` | Media server (requires GPU) |

### Development (dev namespace)

| Service | Image | Version | Notes |
|---------|-------|---------|-------|
| PostgreSQL | `postgres` | `16.6` | Primary database |
| Temporal Server | `temporalio/auto-setup` | `1.25.2` | Workflow orchestration |
| Temporal UI | `temporalio/ui` | `2.35.1` | Temporal web interface |
| TicTac Server | `ghcr.io/droggokid/tictac-server` | `latest` | Custom game server (keep latest for CI/CD) |
| Init Container | `postgres` | `16.6` | For Temporal init |

### Monitoring (monitoring namespace)

| Service | Image | Version | Notes |
|---------|-------|---------|-------|
| Grafana | `grafana/grafana` | `11.4.0` | Dashboarding and visualization |
| VictoriaMetrics | `victoriametrics/victoria-metrics` | `v1.107.0` | Time-series database |
| Kube-State-Metrics | `registry.k8s.io/kube-state-metrics/kube-state-metrics` | `v2.10.1` | Already pinned |
| Node Exporter | `prom/node-exporter` | `v1.8.2` | Host metrics collector |

## Version Selection Guidelines

- **Stable releases**: Use stable release versions (e.g., `1.2.3` not `latest`)
- **Security**: Check CVE databases before upgrading
- **Compatibility**: Verify Kubernetes version compatibility
- **Testing**: Test upgrades in dev namespace first
- **Rollback**: Keep previous version documented for quick rollback

## Useful Commands

```bash
# Check current image versions in cluster
kubectl get pods -A -o jsonpath='{range .items[*]}{.metadata.namespace}{"\t"}{.metadata.name}{"\t"}{.spec.containers[*].image}{"\n"}'

# Pull and inspect an image
docker pull grafana/grafana:11.4.0
docker inspect grafana/grafana:11.4.0

# Check for updates (example for Grafana)
curl -s https://api.github.com/repos/grafana/grafana/releases/latest | jq -r .tag_name
```

## Image Sources

- **FileBrowser**: https://github.com/filebrowser/filebrowser/releases
- **Jellyfin**: https://github.com/jellyfin/jellyfin/releases
- **PostgreSQL**: https://hub.docker.com/_/postgres
- **Temporal**: https://github.com/temporalio/temporal/releases
- **Grafana**: https://github.com/grafana/grafana/releases
- **VictoriaMetrics**: https://github.com/VictoriaMetrics/VictoriaMetrics/releases
- **Node Exporter**: https://github.com/prometheus/node_exporter/releases
