# Update apt repository
echo "Updating apt repository..."
sudo apt update

# Install dependencies
echo "Installing dependencies..."
sudo apt upgrade -y -qq
sudo apt install wget -y -qq
sudo apt install git -y -qq
sudo apt install python3 -y -qq
sudo apt install python3-pip -y -qq
sudo apt install python3-venv -y -qq
sudo apt install python3-dev -y -qq
sudo apt install libssl-dev -y -qq
sudo apt install libffi-dev -y -qq
sudo apt install build-essential -y -qq
sudo apt install docker.io -y -qq
sudo apt install docker-compose -y -qq
sudo apt install docker-compose-plugin -y -qq

#run final tasks
echo "setting up final tools..."
echo "installing CasaOS..."
wget -qO - https://get.casaos.io | sudo bash

echo "this script has been completed successfully"
echo "Please reboot your system to complete the installation."
