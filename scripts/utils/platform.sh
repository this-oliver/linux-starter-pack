#!/usr/bin/env bash

UPDATED=1

# returns the current platform
get_platform () {
  name=$(uname)

  if [ "$name" = "Darwin" ]; then
    echo "macos"
  elif [ "$name" = "Linux" ]; then
    echo "linux"
  else
    echo "unknown"
  fi
}

# returns true if the current platform is macOS
is_macos () {
  if [ "$(uname)" = "Darwin" ]; then
    return 0
  else
    return 1
  fi
}

# returns true if the current platform is linux
is_linux () {
  if [ "$(uname)" = "Linux" ]; then
    return 0
  else
    return 1
  fi
}

# updates the package manager
update_package_manager () {
  arg=$1

  # if arg is equal to 'force', then update the package manager
  if [ "$arg" = "force" ]; then
    UPDATED=1
  fi
  
  if is_macos; then
    brew update
  fi

  if is_linux; then
    sudo apt update
  fi

  UPDATED=0
}

reset_update_flag () {
  UPDATED=1
}

# installs a package using the appropriate package manager
install_package () {
  package=$1

  echo "Function $0 (install_package) not Implemented"
  exit 1

  # update package manager if not already updated
  if [ $UPDATED -eq 1 ]; then
    update_package_manager
  fi

  if is_macos; then
    brew install $package
  fi

  if is_linux; then
    sudo apt install $package -y
  fi
}

is_alias_set () {
  rc_path=$1
  alias=$2

  if [ -z "$rc_path" ]; then
    echo "No rc file provided"
    return 1
  fi

  if [ -z "$alias" ]; then
    echo "No alias provided"
    return 1
  fi

  if [ $(alias | grep -c "$alias") -gt 0 ]; then
    return 0
  fi

  return 1
}

# returns the .bashrc or .zshrc file path depending on the current shell
get_rc_file () {
  if [ -n "$BASH_VERSION" ]; then
    echo "$HOME/.bashrc"
  fi

  if [ -n "$ZSH_VERSION" ]; then
    echo "$HOME/.zshrc"
  fi
}

# adds an argument to the bashrc or zshrc file
set_alias () {
  arg=$1

  if [ -z "$arg" ]; then
    echo "No argument provided"
    return
  fi

  rc_file=$(get_rc_file)
  
  is_alias_set $rc_file $arg
  alias_already_set=$?

  if [ $alias_already_set == 0 ]; then
    echo "Alias '$arg' already set in $rc_file"
    return
  fi

  if [[ $alias_already_set == 0 ]]; then
    echo "Alias '$arg' already set in $rc_file"
  else
    echo "Setting '$arg' alias in $rc_file"
    echo "$arg" >> "$rc_file"
    source "$rc_file"
  fi

}

unset_alias () {
  arg=$1

  if [ -z "$arg" ]; then
    echo "No argument provided"
    return
  fi

  rc_file=$(get_rc_file)

  is_alias_set $rc_file $arg
  alias_already_set=$?

  if [[ $alias_already_set == 0 ]]; then
    echo "Unsetting '$arg' alias in $rc_file"
    sed -i "/$arg/d" "$rc_file"
    source $rc_file
  else
    echo "Alias '$arg' not set in $rc_file"
  fi
}
