#!/bin/bash

# Define environment variables
DB_USER="omer"
DB_PASSWORD="omer"
DB_DATABASE="panaya"
ROOT_PASSWORD="secret"

# Download and install kubeseal
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.19.2/kubeseal-0.19.2-linux-amd64.tar.gz
tar -xvzf kubeseal-0.19.2-linux-amd64.tar.gz
sudo install -m 755 kubeseal /usr/local/bin/kubeseal

# Deploy the Sealed Secrets controller
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.19.2/controller.yaml

# Create the base secret file
cat <<EOF > secrets.yml 
apiVersion: v1
kind: Secret
metadata:
  name: my-db-secret
type: Opaque
data:
  mysql-user: $(echo -n "$DB_USER" | base64)
  mysql-password: $(echo -n "$DB_PASSWORD" | base64)
  mysql-database: $(echo -n "$DB_DATABASE" | base64)
  mysql-root-password: $(echo -n "$ROOT_PASSWORD" | base64)
EOF

# Seal the secret
kubectl create -f secrets.yml --dry-run=client -o yaml | kubeseal --format=yaml > my-sealed-secret.yaml

# Apply the sealed secret
kubectl apply -f my-sealed-secret.yaml
