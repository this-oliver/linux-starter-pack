#!/bin/env bash

mode=$1

# ======= Constants =======

_TOOL_NAME="python"

ALIAS_PYTHON="alias python=python3"
ALIAS_PIP="alias pip=pip3"

# ======= Functions =======

usage() {
  echo "Usage: $0 [install|uninstall]"
}

linux_install() {
  if [ ! -z "$(which python3)" ] || [ ! -z "$(which python)" ]; then
    echo "Python3 is already installed"
    exit 1
  fi
  
  echo "=========== installing $_TOOL_NAME ==========="
  sudo apt install -y python3 python3-pip

  echo "=========== adding $_TOOL_NAME aliases ==========="
  set_alias "$ALIAS_PYTHON"
  set_alias "$ALIAS_PIP"

  echo "*=========== $TOOL_NAME installed successfully ==========="
}

linux_uninstall() {
  echo "========== uninstalling $_TOOL_NAME files ==========="
  sudo apt purge -y python3 python3-pip

  echo "========== removing $_TOOL_NAME aliases ==========="
  unset_alias "$ALIAS_PYTHON"
  unset_alias "$ALIAS_PIP"

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
