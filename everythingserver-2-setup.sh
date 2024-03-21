#!/bin/bash

# Update apt repository
echo "Updating apt repository..."
sudo apt update -qq

# Upgrade packages
echo "Upgrading packages..."
sudo apt upgrade -y -qq

# Install wget (required for downloading Webmin GPG key)
echo "Installing wget..."
sudo apt install wget -y -qq

# Install Webmin
echo "Installing Webmin..."
sudo sh -c 'echo "deb https://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add -
sudo apt update
sudo apt install webmin -y -qq

# Install Samba
echo "Installing Samba..."
sudo apt install samba -y -qq

# Install Apache2
echo "Installing Apache2..."
sudo apt install apache2 -y -qq

# Install Squid Proxy
echo "Installing Squid Proxy..."
sudo apt install squid -y -qq

# Install Pi-hole
echo "Installing Pi-hole..."
git clone --depth 1 https://github.com/pi-hole/pi-hole.git Pi-hole
cd "Pi-hole/automated install/"
sudo bash basic-install.sh -qq

# Install Docker
echo "Installing Docker..."
sudo apt install docker.io -y -qq

# Restart Samba service
sudo systemctl restart smbd 

echo "Setup completed."
