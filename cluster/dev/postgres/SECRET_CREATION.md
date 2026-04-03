# PostgreSQL Secret Creation

This directory contains a `postgres-secret.yaml.example` file that serves as a template.

## Creating the Secret Manually

**IMPORTANT**: Never commit actual secrets to git!

### Option 1: Using kubectl (Recommended)

```bash
# Generate a secure password
POSTGRES_PASSWORD=$(openssl rand -base64 32)

# Create the secret
kubectl create secret generic postgres-credentials \
  --from-literal=POSTGRES_USER=postgres \
  --from-literal=POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
  --from-literal=POSTGRES_DB=postgres \
  -n dev

# Save the password securely (use a password manager!)
echo "PostgreSQL password: ${POSTGRES_PASSWORD}"
```

### Option 2: Using a YAML file (Not Recommended for Production)

1. Copy `postgres-secret.yaml.example` to `postgres-secret.yaml`
2. Replace `YOUR_SECURE_PASSWORD_HERE` with a strong password
3. Apply: `kubectl apply -f postgres-secret.yaml`
4. **Immediately delete the file**: `rm postgres-secret.yaml`

### Option 3: Using Sealed Secrets (Best Practice)

Install sealed-secrets controller:
```bash
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.25.0/controller.yaml
```

Create and seal the secret:
```bash
# Generate password
POSTGRES_PASSWORD=$(openssl rand -base64 32)

# Create temporary secret
kubectl create secret generic postgres-credentials \
  --from-literal=POSTGRES_USER=postgres \
  --from-literal=POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
  --from-literal=POSTGRES_DB=postgres \
  --dry-run=client -o yaml -n dev > /tmp/postgres-secret.yaml

# Seal it
kubeseal -f /tmp/postgres-secret.yaml -w postgres-sealed-secret.yaml

# Apply the sealed secret (safe to commit)
kubectl apply -f postgres-sealed-secret.yaml

# Clean up
rm /tmp/postgres-secret.yaml
```

## Verifying the Secret

```bash
kubectl get secret postgres-credentials -n dev
kubectl describe secret postgres-credentials -n dev
```

## Updating the Password

```bash
# Delete old secret
kubectl delete secret postgres-credentials -n dev

# Create new secret with new password
POSTGRES_PASSWORD=$(openssl rand -base64 32)
kubectl create secret generic postgres-credentials \
  --from-literal=POSTGRES_USER=postgres \
  --from-literal=POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
  --from-literal=POSTGRES_DB=postgres \
  -n dev

# Restart postgres to pick up the new password
kubectl rollout restart deployment/postgres -n dev
```
