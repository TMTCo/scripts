#!/bin/bash

# === CONFIGURATION ===
REPO_NAME="unifi-auto-install"
GITHUB_USER="your_github_username"
GITHUB_TOKEN="your_github_token"  # Generate one at https://github.com/settings/tokens
GIT_PUSH=true  # Set to false if you don't want to push to GitHub

# === Update & Install Dependencies ===
echo "[+] Updating system and installing prerequisites..."
sudo apt update && sudo apt install -y ca-certificates curl gnupg apt-transport-https software-properties-common wget git

# === Install MongoDB 3.6 ===
echo "[+] Adding MongoDB 3.6 repository..."
echo "deb [trusted=yes] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo apt update

echo "[+] Installing MongoDB 3.6..."
sudo apt install -y mongodb-org=3.6.23 mongodb-org-server=3.6.23 mongodb-org-shell=3.6.23 mongodb-org-mongos=3.6.23 mongodb-org-tools=3.6.23

echo "[+] Holding MongoDB versions..."
for pkg in mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools; do
  echo "$pkg hold" | sudo dpkg --set-selections
done

sudo systemctl enable --now mongod

# === Install UniFi Network Application ===
echo "[+] Adding UniFi repository..."
curl -fsSL https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/unifi-repo.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/unifi-repo.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list

echo "[+] Installing UniFi Network Application..."
sudo apt update
sudo apt install -y unifi

echo "[+] Enabling UniFi service..."
sudo systemctl enable --now unifi

# === GitHub Upload (optional) ===
if [ "$GIT_PUSH" = true ]; then
  echo "[+] Preparing GitHub repo upload..."
  mkdir -p "$HOME/$REPO_NAME"
  cp "$0" "$HOME/$REPO_NAME/install-unifi.sh"
  cd "$HOME/$REPO_NAME"

  git init
  git remote add origin "https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
  git add .
  git commit -m "Initial UniFi auto-install script"
  git push -u origin master
  echo "[+] Script uploaded to GitHub: https://github.com/$GITHUB_USER/$REPO_NAME"
fi

# === Final Instructions ===
echo "✅ UniFi installed. Access it via: https://<server-ip>:8443"
