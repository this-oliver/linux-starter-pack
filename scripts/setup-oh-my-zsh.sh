#!/usr/bin/env bash

# ZSH is a shell designed for interactive use. OH-MY-ZSH 
# is a framework for managing zsh configuration. It comes 
# with a lot of plugins and themes.

curr_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $curr_dir/utils/platform.sh

utility="Oh-my-zsh"
system=$(get_platform)
platform_supported=1

if is_linux || is_mac; then
  platform_supported=0
fi

# ==== INSTALLATION


if is_linux; then
  # install zsh
  echo "installing oh-my-zsh..."
  update_package_manager
  sudo apt install zsh

  # make zsh default shell
  sudo chsh -s $(which zsh)

  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if is_mac; then
  # install zsh
  echo "installing oh-my-zsh..."
  brew install zsh

  # make zsh default shell (form apple silicon macs)
  chsh -s /opt/homebrew/bin/zsh

  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ==== CONFIGURATION
# capture theme name in first argument
theme=$1

if is_linux || is_mac; then
  # if theme is provided, set theme
  if [ "$theme" != "" ]; then
      sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"$theme\"/g" ~/.zshrc
  fi

  # set auto suggestion and syntax highlighting plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ==== FEEDBACK

if [ $platform_supported -eq 0 ]; then
  echo "$utility installed successfully"
fi

if [ $platform_supported -ne 0 ]; then
  echo "$utility is not supported by the Setup Scripts on this system ($system)"
fi
