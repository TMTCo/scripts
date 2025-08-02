#!/bin/bash
set -e
OS=$(lsb_release -rs)
if [ "$OS" != "24.04" ]; then
  echo "❌ This script is designed for Ubuntu 24.04 only. Detected: $OS"
  exit 1
fi

echo "== Update system =="
sudo apt update && sudo apt upgrade -y

echo "== Install dependencies =="
sudo apt install -y gnupg curl ca-certificates apt-transport-https software-properties-common openjdk-17-jre-headless

echo "== Add MongoDB 8 repository =="
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-org-8.gpg
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-org-8.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.list

sudo apt update
echo "== Install MongoDB 8 =="
sudo apt install -y mongodb-org

sudo systemctl enable --now mongod
echo "MongoDB status:"; mongod --version

echo "== Add UniFi repo =="
curl -fsSL https://dl.ui.com/unifi/unifi-repo.gpg | sudo gpg --dearmor -o /usr/share/keyrings/unifi-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/unifi-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' |
  sudo tee /etc/apt/sources.list.d/unifi.list

sudo apt update
echo "== Install UniFi Network Application =="
sudo apt install -y unifi

sudo systemctl enable --now unifi

echo "✅ UniFi installed and running!"
echo "Access via: https://$(hostname -I | awk '{print $1}'):8443"
