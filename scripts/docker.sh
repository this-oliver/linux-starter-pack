#!/bin/env bash

mode=$1

# ======= Constants =======

_TOOL_NAME="docker"

# ======= Functions =======

usage() {
  echo "Usage: $0 [install|uninstall]"
}

linux_install() {
  echo "=========== removing old $_TOOL_NAME installations ==========="
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt remove -y $pkg; done
  
  
  echo "=========== adding $_TOOL_NAME gpg key ==========="
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo "=========== adding $_TOOL_NAME repository ==========="
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  echo "=========== installing $_TOOL_NAME ==========="
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "=========== verifying $_TOOL_NAME installation ==========="
  sudo docker run hello-world

  echo "*=========== $TOOL_NAME installed successfully ==========="
}

linux_uninstall() {
  echo "=========== uninstalling $_TOOL_NAME ==========="
  sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
  
  echo "=========== removing $_TOOL_NAME files ==========="
  sudo rm -rf /var/lib/docker
  sudo rm -rf /var/lib/containerd

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
