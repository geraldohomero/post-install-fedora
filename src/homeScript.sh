#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

##########################################################################
## Add update.sh, syncthingStatus.sh and swapAudio.sh to home directory ##
##########################################################################
echo -e "${GREEN}[INFO] - Adding update.sh and syncthingStatus.sh to home directory.${NO_COLOR}"
sleep 2

# Copy the update.sh, syncthingStatus.sh and swapAudio.sh script to the home directory
cp misc/update.sh $HOME
cp misc/syncthingStatus.sh $HOME
cp misc/swapAudio.sh $HOME

echo -e "${GREEN}[INFO] - Making the update.sh, syncthingStatus.sh and swapAudio.sh script executable.${NO_COLOR}"
sleep 2
chmod +x $HOME/update.sh
chmod +x $HOME/syncthingStatus.sh
chmod +x $HOME/swapAudio.sh

########################################################################
## Download megasync-manager.sh to home directory ##
########################################################################
echo -e "${GREEN}[INFO] - Downloading megasync-manager.sh to home directory.${NO_COLOR}"
sleep 2

# Download the script from the provided URL
if wget -O $HOME/megasync-manager.sh "https://raw.githubusercontent.com/geraldohomero/megasync_multiple_instances/refs/heads/main/megasync-manager.sh"; then
    echo -e "${GREEN}[INFO] - Making megasync-manager.sh executable.${NO_COLOR}"
    chmod +x $HOME/megasync-manager.sh
    echo -e "${GREEN}[INFO] - megasync-manager.sh downloaded and set up successfully.${NO_COLOR}"
else
    echo -e "${RED}[ERROR] - Failed to download megasync-manager.sh.${NO_COLOR}"
    exit 1
fi

echo -e "${GREEN}[INFO] - Just type 'update' on the terminal to update/upgrade the system. See /home/.bash_aliases/ for more information.${NO_COLOR}"
echo -e "${GREEN}[INFO] - Just type 'syncstatus' on the terminal to check Syncthing status.${NO_COLOR}"
echo -e "${GREEN}[INFO] - Just type 'swap' on the terminal to swap audio output. It doesn't keep the changes after reboot. Only use when needed.${NO_COLOR}"
echo -e "${GREEN}[INFO] - Just type 'mega' on the terminal to manage MegaSync instances.${NO_COLOR}"
