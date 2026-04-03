# Grafana Admin Credentials

This directory contains configuration for Grafana. The admin credentials are managed via Kubernetes secrets.

## Creating Grafana Admin Secret

**IMPORTANT**: Never use default "admin/admin" credentials in production!

### Recommended Method: kubectl

```bash
# Generate a secure password
GRAFANA_PASSWORD=$(openssl rand -base64 32)

# Create the secret
kubectl create secret generic grafana-admin \
  --from-literal=username=admin \
  --from-literal=password="${GRAFANA_PASSWORD}" \
  -n monitoring

# Save the password securely (use a password manager!)
echo "Grafana admin password: ${GRAFANA_PASSWORD}"
```

### Verifying the Secret

```bash
kubectl get secret grafana-admin -n monitoring
kubectl describe secret grafana-admin -n monitoring
```

### Accessing Grafana

After the secret is created and Grafana is deployed:

1. Navigate to: https://grafana.home.arpa
2. Username: `admin`
3. Password: The password you set when creating the secret

### Resetting the Password

```bash
# Delete old secret
kubectl delete secret grafana-admin -n monitoring

# Create new secret with new password
GRAFANA_PASSWORD=$(openssl rand -base64 32)
kubectl create secret generic grafana-admin \
  --from-literal=username=admin \
  --from-literal=password="${GRAFANA_PASSWORD}" \
  -n monitoring

# Restart Grafana
kubectl rollout restart deployment/grafana -n monitoring

echo "New Grafana password: ${GRAFANA_PASSWORD}"
```

### Using Sealed Secrets (Best Practice)

If you have sealed-secrets installed:

```bash
# Generate password
GRAFANA_PASSWORD=$(openssl rand -base64 32)

# Create temporary secret
kubectl create secret generic grafana-admin \
  --from-literal=username=admin \
  --from-literal=password="${GRAFANA_PASSWORD}" \
  --dry-run=client -o yaml -n monitoring > /tmp/grafana-secret.yaml

# Seal it
kubeseal -f /tmp/grafana-secret.yaml -w grafana-sealed-secret.yaml

# Apply the sealed secret (safe to commit)
kubectl apply -f grafana-sealed-secret.yaml

# Clean up
rm /tmp/grafana-secret.yaml
```
