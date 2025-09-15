#!/bin/bash
########################################################
# Script to configure .bash_aliases and add custom aliases #
########################################################

CUSTOM_ALIASES=(
  'alias ips="ip -c -br a"'
  'alias his="history|grep"'
  'alias ports="netstat -tulanp"'
  'alias update="$HOME/update.sh"'
  'alias upd="$HOME/update.sh"'
  'alias up="$HOME/update.sh"'
  'alias plexstatus="sudo service plexmediaserver status"'
  'alias plexstart="sudo service plexmediaserver start"'
  'alias plexstop="sudo service plexmediaserver stop"'
  'alias mysqlstatus="sudo systemctl status mysql"'
  'alias mysqlstart="sudo systemctl start mysql"'
  'alias mysqlstop="sudo systemctl stop mysql"'
  'alias syncstatus="$HOME/syncthingStatus.sh"'
  'alias neofetch="fastfetch"'
  'alias fetch="fastfetch"'
  'alias swap="$HOME/swapAudio.sh"'
  'alias anaconda="conda activate && QT_XCB_GL_INTEGRATION=none anaconda-navigator"'
  'alias mega-instances="$HOME/megasync-manager.sh"'
  'alias mega="$HOME/megasync-manager.sh"'
  # anaconda-navigator problem on Fedora 41 - Use QT_XCB_GL_INTEGRATION=none anaconda-navigator
  # https://community.anaconda.cloud/t/anaconda-navigator-not-launching-in-fedora-41-gnome-wayland/89433
)

# Check if the script is run as root
if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run as root."
  exit 1
fi

# Color definitions
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

# Define .bashrc configuration
BASHRC_FILE="$HOME/.bashrc"
BASH_ALIASES_SOURCE='
# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi'

# Configure .bashrc to source .bash_aliases
configure_bashrc() {
    # Check if .bashrc exists
    if [[ ! -f "$BASHRC_FILE" ]]; then
        echo -e "${RED}[ERROR] - .bashrc file not found at $BASHRC_FILE${NO_COLOR}"
        exit 1
    fi

    # Create backup of .bashrc
    BACKUP_FILE="$BASHRC_FILE.backup"
    if [[ ! -f "$BACKUP_FILE" ]]; then
        echo -e "${GREEN}[INFO] - Creating backup of original .bashrc...${NO_COLOR}"
        if ! cp "$BASHRC_FILE" "$BACKUP_FILE"; then
            echo -e "${RED}[ERROR] - Failed to create backup file${NO_COLOR}"
            exit 1
        fi
        echo -e "${GREEN}[INFO] - Backup created at $BACKUP_FILE${NO_COLOR}"
    else
        echo -e "${ORANGE}[INFO] - Backup file already exists at $BACKUP_FILE${NO_COLOR}"
    fi

    # Add .bash_aliases sourcing if it doesn't exist
    if ! grep -q "if \[ -f ~/.bash_aliases \]; then" "$BASHRC_FILE"; then
        echo -e "${GREEN}[INFO] - Adding .bash_aliases sourcing to .bashrc...${NO_COLOR}"
        
        # Add newline if needed
        if [[ -n "$(tail -c1 "$BASHRC_FILE")" ]]; then
            echo "" >> "$BASHRC_FILE"
        fi
        
        echo "$BASH_ALIASES_SOURCE" >> "$BASHRC_FILE"
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[SUCCESS] - Successfully added .bash_aliases sourcing to .bashrc${NO_COLOR}"
        else
            echo -e "${RED}[ERROR] - Failed to add .bash_aliases sourcing to .bashrc${NO_COLOR}"
            exit 1
        fi
    else
        echo -e "${ORANGE}[INFO] - .bash_aliases sourcing already exists in .bashrc${NO_COLOR}"
    fi
}

# add aliases to .bash_aliases file
add_aliases() {
  BASH_ALIASES_FILE="$HOME/.bash_aliases"

  # Check if .bash_aliases file exists or create it
  if [[ ! -e "$BASH_ALIASES_FILE" ]]; then
    touch "$BASH_ALIASES_FILE"
    echo "Created .bash_aliases file in the home directory."
  else
    echo ".bash_aliases file already exists in the home directory."
  fi

  # Check if the aliases are already present in .bash_aliases
  for alias_line in "${CUSTOM_ALIASES[@]}"; do
    if ! grep -qF "$alias_line" "$BASH_ALIASES_FILE"; then
      echo "$alias_line" >> "$BASH_ALIASES_FILE"
      echo "Added: $alias_line"
    else
      echo "Alias already exists: $alias_line"
    fi
  done
}

# Execute the functions
configure_bashrc
add_aliases

# Source the updated .bashrc
echo -e "${GREEN}[INFO] - Reloading .bashrc...${NO_COLOR}"
source "$BASHRC_FILE"