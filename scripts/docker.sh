#!/bin/env bash

mode=$1

usage() {
  echo "Usage: $0 [install|uninstall]"
}

linux_install() {
  echo "=========== removing old docker installations ==========="
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
  
  
  echo "=========== adding docker gpg key ==========="
  sudo apt-get update
  sudo apt-get install ca-certificates curl -y
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo "=========== adding docker repository ==========="
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  echo "=========== installing docker ==========="
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

  echo "=========== verifying docker installation ==========="
  sudo docker run hello-world
}

linux_uninstall() {
  echo "=========== uninstalling docker ==========="
  sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
  
  echo "=========== removing docker files ==========="
  sudo rm -rf /var/lib/docker
  sudo rm -rf /var/lib/containerd
}

if [ -z "$mode" ]; then
  mode="install"
fi

if [ "$mode" = "install" ]; then
  linux_install
elif [ "$mode" = "uninstall" ]; then
  linux_uninstall
else
  echo "Invalid mode: '$mode'"
  usage
  exit 1
fi
