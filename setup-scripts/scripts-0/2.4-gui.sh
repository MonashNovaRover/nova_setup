#!/bin/bash

# Source the setup file for colours and formatting
source ./scripts-0/0-script-setup.sh

# Install GUI
information "Installing GUI Tools..."
sudo apt install -y nodejs-dev node-gyp libssl1.0-dev
sudo apt install -y npm
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g npm@7.11.2
pip3 install flask_cors
pip3 install flask_socketio
