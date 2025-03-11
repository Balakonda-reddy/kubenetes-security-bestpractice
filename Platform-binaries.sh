# ╭──────────────────────────────────────────────────────────────────╮
# │ NOTE: This is a reference implementation for educational purposes │
# │ Please test thoroughly before applying to production environments │
# ╰──────────────────────────────────────────────────────────────────╯

#!/bin/bash
# kubernetes-binary-verification.sh
# Script to verify Kubernetes binary downloads

# Set Kubernetes version
K8S_VERSION="1.26.0"
DOWNLOAD_DIR="/tmp/k8s-download"

# Create download directory
mkdir -p $DOWNLOAD_DIR
cd $DOWNLOAD_DIR

# Download binaries and checksums
echo "Downloading Kubernetes $K8S_VERSION binaries..."
curl -LO "https://dl.k8s.io/release/v${K8S_VERSION}/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/v${K8S_VERSION}/bin/linux/amd64/kubelet"
curl -LO "https://dl.k8s.io/release/v${K8S_VERSION}/bin/linux/amd64/kubeadm"

# Download checksums
echo "Downloading checksums..."
curl -LO "https://dl.k8s.io/v${K8S_VERSION}/bin/linux/amd64/kubectl.sha256"
curl -LO "https://dl.k8s.io/v${K8S_VERSION}/bin/linux/amd64/kubelet.sha256"
curl -LO "https://dl.k8s.io/v${K8S_VERSION}/bin/linux/amd64/kubeadm.sha256"

# Verify checksums
echo "Verifying kubectl..."
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
echo "Verifying kubelet..."
echo "$(cat kubelet.sha256)  kubelet" | sha256sum --check
echo "Verifying kubeadm..."
echo "$(cat kubeadm.sha256)  kubeadm" | sha256sum --check

# Optional: Download and verify GPG signatures if available
# curl -LO "https://dl.k8s.io/release/v${K8S_VERSION}/bin/linux/amd64/kubectl.sig"
# gpg --verify kubectl.sig kubectl

echo "Verification complete. If all checks passed, binaries are verified."
echo "Install binaries to /usr/local/bin with:"
echo "sudo install -o root -g root -m 0755 kubectl kubelet kubeadm /usr/local/bin/"
