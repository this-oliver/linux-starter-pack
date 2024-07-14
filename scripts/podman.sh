#!/bin/env bash

mode=$1

# ======= Constants =======

_TOOL_NAME="podman"

# ======= Functions =======

usage() {
  echo "Usage: $0 [install|uninstall]"
}

linux_install() {
  echo "=========== installing $_TOOL_NAME ==========="
  sudo apt update
  sudo apt install -y podman

  echo "=========== verifying $_TOOL_NAME installation ==========="
  sudo podman run hello-world

  echo "*=========== $TOOL_NAME installed successfully ==========="
}

linux_uninstall() {
  echo "=========== uninstalling $_TOOL_NAME ==========="
  sudo apt purge -y podman

  echo "========== removing $_TOOL_NAME files ==========="
  sudo rm -rf /var/lib/containers
  sudo rm -rf /var/lib/podman

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
