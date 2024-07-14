#!/bin/env bash

mode=$1

# ======= Constants =======

_TOOL_NAME="nodejs"

# ======= Functions =======

usage() {
  echo "Usage: $0 [install|uninstall]"
}

linux_install() {
  echo "=========== installing $_TOOL_NAME ==========="
  # installs nvm (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  # installs nodejs (you may need to restart the terminal)
  nvm install 20
  # installs pnpm (Package Nodejs Manager)
  npm install -g pnpm

  echo "=========== verifying $_TOOL_NAME installation ==========="
  node -v
  npm -v
  pnpm -v
  sudo podman run hello-world

  echo "*=========== $TOOL_NAME installed successfully ==========="
}

linux_uninstall() {
  echo "========== removing $_TOOL_NAME files ==========="
  rm -rf $NVM_DIR ~/.npm ~/.bower

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
