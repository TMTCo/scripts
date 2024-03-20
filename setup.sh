#!/bin/bash

# Update apt repository
echo "Updating apt repository..."
sudo apt update

# Upgrade packages
echo "Upgrading packages..."
sudo apt upgrade -y

# Install wget (required for downloading Webmin GPG key)
echo "Installing wget..."
sudo apt install wget -y

# Install Webmin
echo "Installing Webmin..."
sudo sh -c 'echo "deb https://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add -
sudo apt update
sudo apt install webmin -y

# Install Samba
echo "Installing Samba..."
sudo apt install samba -y

# Install Apache2
echo "Installing Apache2..."
sudo apt install apache2 -y

# Install Squid Proxy
echo "Installing Squid Proxy..."
sudo apt install squid -y

# Install Docker
echo "Installing Docker..."
sudo apt install docker.io -y

# Restart Samba service
sudo systemctl restart smbd

echo "Setup completed."
