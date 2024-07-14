#!/bin/env bash

mode=$1

curr_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $curr_dir/utils/platform.sh

# ======= Constants =======

_TOOL_NAME="basic tools"

ALIAS_BATCAT="alias bat=batcat"

# ======= Functions =======

usage() {
  echo "Usage: $0 [install|uninstall]"
}

linux_install() {

  echo "=========== installing $_TOOL_NAME ==========="
  sudo apt install -y curl git nmap bat

  echo "=========== setting $_TOOL_NAME aliases ==========="
  echo "$ALIAS_BATCAT" >> ~/.bashrc
  echo "Don't forget to run 'source ~/.bashrc' to apply changes"

  echo "*=========== $TOOL_NAME installed successfully ==========="
}

linux_uninstall() {
  echo "=========== uninstalling $_TOOL_NAME ==========="
  sudo apt purge -y curl git nmap bat

  echo "=========== removing $_TOOL_NAME aliases ==========="
  sed -i "/$ALIAS_BATCAT/d" ~/.bashrc
  echo "Don't forget to run 'source ~/.bashrc' to apply changes"

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
