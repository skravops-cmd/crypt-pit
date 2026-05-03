# Crypt-Pit - Password Generator

A modern, animated password generator built with HTML, CSS, and JavaScript. Deployed using ArgoCD with multiple deployment strategies.

## 🚀 Deployment Options

This repository supports three deployment methods for ArgoCD:

### Option 1: Basic Kubernetes Manifests
**Location**: `k8s/base/`
- Simple, straightforward Kubernetes manifests
- No additional tools required
- Perfect for learning and small deployments

### Option 2: Helm Chart
**Location**: `k8s/helm/crypt-pit/`
- Reusable and versioned deployments
- Template-based configuration
- Industry standard for Kubernetes applications

### Option 3: Kustomize
**Location**: `k8s/overlays/`
- Environment-specific customizations
- Declarative configuration management
- Great for multi-environment deployments

## 📋 Prerequisites

1. **ArgoCD** installed in your cluster
2. **Traefik Ingress Controller** configured
3. **Cloudflare** SSL/TLS proxy enabled for `crypt.skravops.xyz`
4. **GitHub Container Registry** access (for automated builds)

## 🔧 Cloudflare SSL Setup

1. **DNS Configuration**:
   - Point `crypt.skravops.xyz` to your cluster's IP
   - Enable Cloudflare proxy (orange cloud)

2. **SSL/TLS Settings**:
   - SSL/TLS encryption mode: `Full (strict)`
   - Always Use HTTPS: `On`
   - Minimum TLS Version: `1.2`

3. **Edge Certificates**:
   - Enable "Always Use HTTPS"
   - Enable "Automatic HTTPS Rewrites"

## 🚀 Deployment Steps

### Step 1: Push to GitHub
```bash
git add .
git commit -m "Add ArgoCD deployment manifests"
git push origin main
```

### Step 2: Build Docker Image
The GitHub Actions workflow will automatically build and push the image to GHCR.

### Step 3: Deploy via ArgoCD

Choose one of the deployment options:

#### Option A: Basic Manifests
```bash
kubectl apply -f argocd/crypt-pit-basic.yaml
```

#### Option B: Helm Chart
```bash
kubectl apply -f argocd/crypt-pit-helm.yaml
```

#### Option C: Kustomize
```bash
kubectl apply -f argocd/crypt-pit-kustomize.yaml
```

### Step 4: Access Your Application
- **URL**: https://crypt.skravops.xyz
- **SSL**: Handled by Cloudflare
- **Ingress**: Traefik routes traffic to your pods

## 🔍 Monitoring & Troubleshooting

### Check ArgoCD Application Status
```bash
kubectl get applications -n argocd
kubectl get application crypt-pit-* -n argocd -o wide
```

### View Application Logs
```bash
kubectl logs -n default deployment/crypt-pit
```

### Check Ingress
```bash
kubectl get ingress -n default
kubectl describe ingress crypt-pit
```

### Test Application
```bash
curl -I https://crypt.skravops.xyz
```

## 🏗️ Architecture

```
Internet → Cloudflare (SSL/TLS) → Traefik Ingress → Service → Pods
```

- **Cloudflare**: Handles SSL termination and DDoS protection
- **Traefik**: Routes traffic to Kubernetes services
- **Kubernetes**: Manages container orchestration
- **ArgoCD**: GitOps continuous deployment

## 🔄 CI/CD Pipeline

The GitHub Actions workflow:
1. Builds Docker image on every push to `main`
2. Pushes to GitHub Container Registry (GHCR)
3. Deploys to staging environment automatically
4. Tags images with commit SHA for traceability

## 🌍 Multi-Environment Support

- **Production**: `k8s/overlays/production/` (3 replicas, higher resources)
- **Staging**: `k8s/overlays/staging/` (1 replica, minimal resources)

## 📊 Resource Requirements

- **CPU**: 50m request / 100m limit
- **Memory**: 64Mi request / 128Mi limit
- **Replicas**: 2 (production), 1 (staging)

## 🔒 Security Features

- Cloudflare SSL/TLS encryption
- Kubernetes network policies
- Resource limits and requests
- Non-root container execution
- Read-only filesystem

## 🛠️ Development

### Local Development
```bash
# Run locally with Docker Compose
docker compose up -d

# Access at http://localhost
```

### Testing Changes
```bash
# Test Kustomize build
kubectl kustomize k8s/overlays/production/

# Test Helm template
helm template crypt-pit k8s/helm/crypt-pit/

# Validate manifests
kubectl apply --dry-run=client -f k8s/base/
```

## 📞 Support

If you encounter issues:
1. Check ArgoCD application status
2. Verify Cloudflare DNS configuration
3. Check Traefik ingress logs
4. Validate Kubernetes pod status

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with all deployment options
5. Submit a pull request
