#!/usr/bin/env bash
set -Eeuo pipefail

RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
PURPLE='\e[1;95m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

# Ensure the script is not run as root
if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
  echo -e "${RED}[ERROR] - Do not run run.sh with sudo/root. Run it as your regular user.${NO_COLOR}"
  exit 1
fi

# Change to repository directory (directory where this script is located)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"


# Make all files in src/ directory executable
echo -e "${GREEN}[INFO] - Making all files in src/ directory executable...${NO_COLOR}"
chmod +x ./src/*

echo -e "${GREEN}[INFO] - Optimizing DNF configuration...${NO_COLOR}"
sleep 2

# Run the DNF configuration optimization script
./src/dnf-config.sh

echo -e "${GREEN}[INFO] - Post-installation script will be executed.${NO_COLOR}"
sleep 2

# Add after making scripts executable and before running post-install.sh
echo -e "${GREEN}[INFO] - Configuring .bash_aliases in .bashrc...${NO_COLOR}"
sleep 2

# Run the .bash_aliases script
./src/alias.sh

# Run the post-install script
./src/post-install.sh

echo -e "${GREEN}[INFO] - .bash_aliases script will be executed.${NO_COLOR}"
sleep 2

echo -e "${GREEN}[INFO] - Configuring Windscribe VPN...${NO_COLOR}"
sleep 2

# Run the VPN installation script
./src/vpn.sh

echo -e "${PURPLE}[INFO] - Now some additional steps will be executed.${NO_COLOR}"
sleep 2

# Add update.sh, syncthingStatus.sh and swapAudio. to home directory
./src/homeScript.sh

# Clone all repositories from USER on GitHub (optional)
echo -e "${GREEN}[INFO] - Do you want to run the GitHub step (clone + git config)? [y/N]${NO_COLOR}"
read -r RUN_GITHUB_SETUP

case "$RUN_GITHUB_SETUP" in
  [yY]|[yY][eE][sS])
    echo -e "${GREEN}[INFO] - Running githubCloneAndConfig.sh...${NO_COLOR}"
    ./src/githubCloneAndConfig.sh || {
      echo -e "${RED}[ERROR] - Failed to run githubCloneAndConfig.sh.${NO_COLOR}"
      exit 1
    }
    ;;
  *)
    echo -e "${ORANGE}[INFO] - GitHub step skipped by user.${NO_COLOR}"
    ;;
esac

# Alt + tab config
./src/altTab.sh

# create fastfetch config file
fastfetch --gen-config

# Add some development tools like node, anaconda, R... 
./src/devEnv.sh

echo -e "${GREEN}[SUCCESS] --- | --- | --- [SUCCESS]${NO_COLOR}"
sleep 2