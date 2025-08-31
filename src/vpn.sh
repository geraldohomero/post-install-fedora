#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

echo -e "${GREEN}Installing Windscribe VPN...${NO_COLOR}"
    cd /tmp || { echo -e "${RED}Failed to change directory to /tmp.${NO_COLOR}"; exit 1; }
    if ! wget -O windscribe.rpm "https://windscribe.com/install/desktop/linux_rpm_x64"; then
        echo -e "${RED}Failed to download Windscribe RPM package.${NO_COLOR}"
        exit 1
    fi
    if command -v dnf &>/dev/null; then
        if ! sudo dnf install -y windscribe.rpm; then
            echo -e "${ORANGE}dnf install failed, trying rpm...${NO_COLOR}"
            if ! sudo rpm -i windscribe.rpm; then
                echo -e "${RED}Failed to install Windscribe VPN with rpm.${NO_COLOR}"
                rm -f windscribe.rpm
                exit 1
            fi
        fi
    else
        if ! sudo rpm -i windscribe.rpm; then
            echo -e "${RED}Failed to install Windscribe VPN with rpm.${NO_COLOR}"
            rm -f windscribe.rpm
            exit 1
        fi
    fi
    rm -f windscribe.rpm
    echo -e "${GREEN}Windscribe VPN installation completed.${NO_COLOR}"
    