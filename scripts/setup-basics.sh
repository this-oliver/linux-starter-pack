#!/usr/bin/env bash

# This script installs some common tools that are used in development
# environments.
# 
# Below is a short description of each tool:
#   - curl: a command line tool and library for transferring data with URLs
#   - git: a distributed version control system
#   - nmap: a network exploration tool and security / port scanner
#   - bat: a cat clone with syntax highlighting and Git integration

curr_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $curr_dir/utils/platform.sh

utility="Basic tools"
system=$(get_platform)
platform_supported=1

if is_linux || is_mac; then
  platform_supported=0
fi

# ==== INSTALLATION

if is_linux; then
  update_package_manager
  sudo apt install curl git nmap bat -y
fi

if is_mac; then
  brew install curl git nmap bat
fi

# ==== CONFIGURATION

if is_linux || is_mac; then
  # check if bat is renamed to batcat
  batcat_path=$(which batcat)

  # if batcat is found, set alias for batcat
  if [ "$batcat_path" != "" ]; then
      set_run_command "alias bat=batcat"
  fi
fi

# ==== FEEDBACK
if [ $platform_supported -eq 0 ]; then
  echo "$utility installed successfully"
fi

if [ $platform_supported -ne 0 ]; then
  echo "$utility is not supported by the Setup Scripts on this system ($system)"
fi
