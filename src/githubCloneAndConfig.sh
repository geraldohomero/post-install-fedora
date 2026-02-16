#!/usr/bin/env bash
set -Eeuo pipefail

RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

#################################################
## Clone all repositories from USER on GitHub  ##
## And verify if GitHub CLI is installed       ##
#################################################
echo -e "${GREEN}[INFO] - Checking if GitHub CLI is installed...${NO_COLOR}"
if ! command -v gh &> /dev/null; then
  echo -e "${RED}[ERROR] - GitHub CLI is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing GitHub CLI...${NO_COLOR}"
  sudo dnf install gh -y
  echo -e "${GREEN}[INFO] - GitHub CLI has been successfully installed.${NO_COLOR}"
else
  echo -e "${ORANGE}[INFO] - GitHub CLI is already installed.${NO_COLOR}"
fi
sleep 2

if gh auth status &> /dev/null; then
  echo -e "${ORANGE}[INFO] - GitHub CLI is already authenticated.${NO_COLOR}"
else
  echo -e "${GREEN}[INFO] - Starting GitHub CLI authentication...${NO_COLOR}"
  gh auth login
fi

# Clone all repositories from USER on GitHub
echo -e "${GREEN}[INFO] - Enter the GitHub ${RED}username ${GREEN}to clone the repositories:${NO_COLOR}"
echo -n "GitHub username: "
read -r USER

if [[ -z "$USER" ]]; then
  echo -e "${RED}[ERROR] - GitHub username cannot be empty.${NO_COLOR}"
  exit 1
fi

##########################################
# Change to the directory where you want # 
# to clone all the repositories          #
##########################################
DIRECTORY_PATH="$HOME/Documents/Github"  #
##########################################

mkdir -p "$DIRECTORY_PATH"

echo -e "${GREEN}[INFO] - Cloning all repositories from $USER on GitHub to $DIRECTORY_PATH.${NO_COLOR}"
gh repo list "$USER" --limit 1000 --json nameWithOwner --jq '.[].nameWithOwner' | while read -r repo; do
  [[ -z "$repo" ]] && continue
  target_path="$DIRECTORY_PATH/$repo"

  if [[ -d "$target_path" ]]; then
    echo -e "${ORANGE}[INFO] - Skipping existing repository: $repo${NO_COLOR}"
    continue
  fi

  echo -e "${GREEN}[INFO] - Cloning $repo...${NO_COLOR}"
  gh repo clone "$repo" "$target_path"
done


# Configure git global user name and email
echo -e "${GREEN}[INFO] - Configuring git global settings...${NO_COLOR}"
echo -e "${GREEN}[INFO] - Enter your name for git config:${NO_COLOR}"
echo -n "Name: "
read -r GIT_NAME

echo -e "${GREEN}[INFO] - Enter your email for git config:${NO_COLOR}"
echo -n "Email: "
read -r GIT_EMAIL

if [[ -n "$GIT_NAME" ]]; then
  git config --global user.name "$GIT_NAME"
fi

if [[ -n "$GIT_EMAIL" ]]; then
  git config --global user.email "$GIT_EMAIL"
fi

echo -e "${GREEN}[INFO] - Git global config has been set:${NO_COLOR}"
echo -e "${BLUE}Name: ${NO_COLOR}$(git config --global user.name 2>/dev/null || true)"
echo -e "${BLUE}Email: ${NO_COLOR}$(git config --global user.email 2>/dev/null || true)"
