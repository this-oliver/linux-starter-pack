# Workstation

Imagine you have a brand new Linux machine or you want to reinstall your OS or you kinda messed up your system, but you want to have your old setup back. This repository offers you the possibility to install and configure developement utilities/tools on a fresh Linux system with a single command.

The following tools are installed by default:

- `curl` for interacting with and downloading from the web
- `git` for version control (and fetching remote repositories)
- `bat` for syntax highlighting
- `nmap` for network discovery

Additionally, the following tools can be installed if you want:

- `docker` for containerization
- `podman` for containerization (security-focused alternative to docker)
- `nodejs` for running JavaScript
- `python` for running Python
- `oh-my-zsh` for a better shell experience

## Usage

> **Use the script at your own risk.** As always, it is recommended to review the script before running it (effort has been made to document each step in the script).

```bash
# clone the repository
git clone https://github.com/this-oliver/setup-scripts.git

# change into the directory
cd setup-scripts

# make the install script executable
chmod +x install.sh

# run the script
./install.sh
```

## How it works

At a high level, the repository is organized as follows:

- `install.sh` script is the entry point for the installation process.
- `scripts/*.sh` files contain the logic for installing the utilities/tools.
- `script/utils/` directory contains logic that is reused across the installation process.

With the structure in mind, the installation process works as follows:

1. The `install.sh` script gathers all the utilities/tools that the user wants to install.
2. The `install.sh` script then runs the installation scripts for the selected utilities/tools.
   1. Each installation script inspects the system to determine if the tool is supported or not.
   2. If the tool is supported, the installation script decides which package manager to use and installs the tool.
   3. Once the tool is installed, the installation script configures the tool and defines some common aliases which are inserted into the user's `.bashrc` or `.zshrc` file (priority is given to `.zshrc`).
