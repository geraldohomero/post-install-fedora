#!/usr/bin/env bash
#-----------https://github.com/geraldohomero/-------------#
#----------https://geraldohomero.github.io/---------------#
#------------A personal script project-------------------#

RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

DOWNLOAD_PROGRAMS_DIRECTORY="$HOME/Downloads/Programs"
PROGRAMS_TO_INSTALL_RPM=(
  
)

PROGRAMS_TO_INSTALL_DNF=(
  btop
  java-1.8.0-openjdk
  obs-studio
  hugo
  vim
  neovim
  firewall-config
  git
  gnome-font-viewer
  gnome-tweaks
  gnome-themes-extra
  gh
  steam
  code
  yt-dlp
  fastfetch
  vlc
)

PROGRAMS_TO_INSTALL_FLATPAK=(
  org.qbittorrent.qBittorrent
  org.kde.okular
  org.zotero.Zotero
  org.gnome.Characters
  org.gnome.World.PikaBackup
  com.bitwarden.desktop
  com.brave.Browser
  com.heroicgameslauncher.hgl
  com.microsoft.Edge
  com.spotify.Client
  com.axosoft.GitKraken
  com.github.tchx84.Flatseal
  it.mijorus.gearlever
  com.github.tenderowl.frog
  com.google.AndroidStudio
  md.obsidian.Obsidian
  nl.hjdskes.gcolor3
  io.gitlab.librewolf-community
  io.missioncenter.MissionCenter
  rest.insomnia.Insomnia
)

# Function to check internet connectivity
check_internet() {
  if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
    echo -e "${RED}[ERROR] - Your computer does not have an Internet connection.${NO_COLOR}"
    exit 1
  else
    echo -e "${GREEN}[INFO] - Internet connection verified.${NO_COLOR}"
  fi
}

# Function to check if a program is installed
check_program_installed() {
  local program=$1
  if ! command -v "$program" &> /dev/null; then
    echo -e "${RED}[ERROR] - The $program program is not installed.${NO_COLOR}"
    echo -e "${GREEN}[INFO] - Installing $program...${NO_COLOR}"
    sudo dnf install "$program" -y &> /dev/null || { echo -e "${RED}[ERROR] - Failed to install $program.${NO_COLOR}"; exit 1; }
  else
    echo -e "${ORANGE}[INFO] - The $program program is already installed.${NO_COLOR}"
  fi
}

#--------------Validations-------------#
check_internet
check_program_installed wget

# Updates and upgrades #
upgrade_cleanup () {
  echo -e "${GREEN}[INFO] - Performing upgrade and cleanup...${NO_COLOR}"
  sleep 1
  sudo dnf clean all
  sudo dnf check
  sudo dnf upgrade -y
  sudo dnf autoremove -y
  flatpak update -y
}

# Installing packages and programs #
install_dnf_packages() {
  # Enable RPM Fusion repositories
  echo -e "${GREEN}[INFO] - Enabling RPM Fusion repositories...${NO_COLOR}"
  sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  # Enable VS Code repository
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

  for program in ${PROGRAMS_TO_INSTALL_DNF[@]}; do
    if ! rpm -q "$program" &> /dev/null; then
      echo -e "${GREEN}[INFO] - Installing $program...${NO_COLOR}"
      sudo dnf install "$program" -y &> /dev/null || { echo -e "${RED}[ERROR] - Failed to install $program.${NO_COLOR}"; exit 1; }
    else
      echo -e "${ORANGE}[INFO] - The package $program is already installed.${NO_COLOR}"
    fi
  done
}

install_flatpak () {
  # Add Flathub repository
  if ! flatpak remote-list | grep -q "flathub"; then
    echo -e "${GREEN}[INFO] - Installing Flathub...${NO_COLOR}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  else
    echo -e "${ORANGE}[INFO] - Flathub repository is already added.${NO_COLOR}"
  fi
  
  # Install flatpak packages
  for program in ${PROGRAMS_TO_INSTALL_FLATPAK[@]}; do
    if ! flatpak list | grep -q $program; then
      echo -e "${GREEN}[INFO] - Installing $program...${NO_COLOR}"
      flatpak install flathub $program -y
    else
      echo -e "${ORANGE}[INFO] - $program flatpak is already installed.${NO_COLOR}"
    fi
  done
}

download_rpm_packages () {
  # Add the directory for downloads if it does not exist
  [[ ! -d "$DOWNLOAD_PROGRAMS_DIRECTORY" ]] && mkdir "$DOWNLOAD_PROGRAMS_DIRECTORY"

  for url in "${PROGRAMS_TO_INSTALL_RPM[@]}"; do
    package_name=$(basename "$url")
    destination_path="$DOWNLOAD_PROGRAMS_DIRECTORY/$package_name"

    echo -e "${GREEN}[INFO] - Downloading package from URL: $url${NO_COLOR}"
    wget -c "$url" -P "$DOWNLOAD_PROGRAMS_DIRECTORY" &> /dev/null

    echo -e "${GREEN}[INFO] - Installing package: $package_name${NO_COLOR}"
    sudo dnf install "$destination_path" -y
  done
}

install_syncthing () {
  echo -e "${GREEN}[INFO] - Installing Syncthing...${NO_COLOR}"
  sudo dnf install syncthing -y
  echo -e "${GREEN}[INFO] - Syncthing installation completed successfully.${NO_COLOR}"
}

# Android Studio
add_android_sdk () {
  echo -e "${GREEN}[INFO] - Adding Android SDK to the PATH...${NO_COLOR}"
  echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
  echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.bashrc
}

#----# Execution #----#
install_dnf_packages
upgrade_cleanup
install_flatpak
download_rpm_packages
install_syncthing
add_android_sdk
