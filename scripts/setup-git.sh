#!/bin/env bash

curr_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $curr_dir/utils/platform.sh
source $curr_dir/utils/checker.sh

setup() {
  read -p "Enter your name: " name
  read -p "Enter your email: " email
  read -p "Do you also want to sign your commits with SSH keys? (y/N): " ssh_keys

  if is_yes $ssh_keys; then
    read -p "Enter the path to your ssh key: " ssh_key_path
  fi

  echo "=== Setting global git configuration ==="
  git config --global user.name "$name"
  git config --global user.email "$email"

  if is_yes $ssh_keys; then
    echo "=== Setting up ssh keys for git ==="
    git config --global gpg.format ssh
    git config --global user.signingkey $ssh_key_path
  fi

  echo "=== Global git configuration set ==="
}

teardown() {
  read -p "Do you want to remove your global git configuration? (y/N): " remove

  if is_yes $remove; then
    echo "=== Removing global git configuration ==="
    git config --global --unset user.name
    git config --global --unset user.email
    git config --global --unset user.signingkey

    echo "=== Global git configuration removed ==="
  fi
}

if [ "$1" = "teardown" ]; then
  teardown
else
  setup
fi