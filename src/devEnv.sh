#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

###############################
# Add some development tools  #
###############################
echo -e "${PURPLE}[INFO] - Installing development tools...${NO_COLOR}"

# Node.js
if ! command -v node &> /dev/null; then
  echo -e "${RED}[ERROR] - Node.js is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing Node.js...${NO_COLOR}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install 20
  echo -e "${GREEN}[INFO] - Node.js has been successfully installed.${NO_COLOR}"
else
  echo -e "${ORANGE}[INFO] - Node.js is already installed.${NO_COLOR}"
fi

# Anaconda https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh
if ! command -v conda &> /dev/null; then
  echo -e "${RED}[ERROR] - Anaconda is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing Anaconda...${NO_COLOR}"
    wget https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh -O ~/anaconda.sh
    bash ~/anaconda.sh -b -p $HOME/anaconda3
    rm ~/anaconda.sh
    echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
  echo -e "${GREEN}[INFO] - Anaconda has been successfully installed.${NO_COLOR}"
else
  echo -e "${ORANGE}[INFO] - Anaconda is already installed.${NO_COLOR}"
fi

# R and RStudio will be added with Distrobox or Podman (Using Ubuntu)