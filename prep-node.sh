#!/bin/bash

apt-get update && apt-get upgrade -y
apt-get install -y socat curl git

git clone https://github.com/Gozargah/Marzban-node
cd Marzban-node

curl -fsSL https://get.docker.com | sh

cat > docker-compose.yml << 'EOF'
services:
  marzban-node:
    image: gozargah/marzban-node:latest
    restart: always
    network_mode: host

    volumes:
      - /var/lib/marzban-node:/var/lib/marzban-node
      - /var/lib/marzban:/var/lib/marzban

    environment:
      SSL_CLIENT_CERT_FILE: "/var/lib/marzban-node/ssl_client_cert.pem"
      SERVICE_PROTOCOL: rest
EOF

mkdir -p /var/lib/marzban-node/

nano /var/lib/marzban-node/ssl_client_cert.pem

chmod 600 /var/lib/marzban-node/ssl_client_cert.pem

docker compose up -d
