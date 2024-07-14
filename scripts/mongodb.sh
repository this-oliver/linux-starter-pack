#!/bin/env bash

mode=$1

# ======= Constants =======

_TOOL_NAME="mongodb"

# ======= Functions =======

usage() {
  echo "Usage: $0 [install|uninstall]"
}

linux_install() {
  echo "=========== verifying OS compatibility with $_TOOL_NAME ==========="
  if ! lsb_release -c | grep -E "jammy|focal"; then
    echo "This script is only compatible with Ubuntu 22.04 (Jammy Jellyfish) or Ubuntu 20.04 (Focal Fossa)."
    exit 1
  fi

  echo "=========== adding $_TOOL_NAME gpg key ==========="
  sudo apt install -y gnupg curl
  sudo curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
  sudo echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

  echo "=========== installing $_TOOL_NAME ==========="
  sudo apt update
  sudo apt install -y mongodb-org

  echo "=========== configuring $_TOOL_NAME for systemctl ==========="
  sudo systemctl start mongod # start mongod service
  sudo systemctl enable mongod # ensure that mongod starts on boot
  # sudo systemctl daemon-reload # Uncomment if you receive error "Failed to start mongod.service: Unit mongod.service not found."

  echo "*=========== $TOOL_NAME installed successfully ==========="
}

linux_uninstall() {
  echo "=========== stoping $_TOOL_NAME service ==========="
  sudo service mongod stop

  echo "=========== uninstalling $_TOOL_NAME ==========="
  sudo apt purge -y mongodb-org*

  echo "========== removing $_TOOL_NAME files ==========="
  sudo rm -r /var/log/mongodb /var/lib/mongodb

  echo "*=========== $TOOL_NAME uninstalled successfully ==========="
}

# ======= Main =======

if [ "$mode" = "install" ] || [ -z "$mode" ]; then
  linux_install
elif [ "$mode" = "uninstall" ]; then
  linux_uninstall
else
  echo "Invalid mode: '$mode'"
  usage
  exit 1
fi
