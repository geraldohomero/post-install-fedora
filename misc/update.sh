RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'

check_internet() {
  if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
    echo -e "${RED}[ERROR] - Your computer does not have an Internet connection.${NO_COLOR}"
    exit 1
  else
    echo -e "${GREEN}[INFO] - Internet connection verified.${NO_COLOR}"
  fi
}

upgrade_cleanup () {
  echo -e "${GREEN}[INFO] - Performing upgrade and cleanup...${NO_COLOR}"
  sudo dnf check
  sudo dnf upgrade
  sudo dnf autoremove
  flatpak update
}

check_internet
upgrade_cleanup 
