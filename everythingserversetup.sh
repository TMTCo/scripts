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

# Making folder Media
echo "creating /media... Please wait"
mkdir /media

# Install Docker
echo "Installing Docker..."
sudo apt install docker.io -y

# Configure Samba to share /media directory
echo "Configuring Samba..."
sudo bash -c 'cat <<EOF >> /etc/samba/smb.conf

[media]
   path = /media
   browsable = yes
   writable = yes
   guest ok = yes
   create mask = 0777
   directory mask = 0777
EOF'

# Restart Samba service
sudo systemctl restart smbd

# Run additional command
echo "Running additional command..."
curl -fsSL https://get.casaos.io | sudo bash

echo "Setup completed."
