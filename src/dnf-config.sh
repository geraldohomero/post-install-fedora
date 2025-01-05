#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

# DNF configuration file path
DNF_CONF="/etc/dnf/dnf.conf"
BACKUP_FILE="$DNF_CONF.backup"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    echo -e "${RED}[ERROR] - This script should not be run as root${NO_COLOR}"
    exit 1
fi

# Check if DNF configuration file exists
if [[ ! -f "$DNF_CONF" ]]; then
    echo -e "${RED}[ERROR] - DNF configuration file not found at $DNF_CONF${NO_COLOR}"
    exit 1
fi

# Create backup only if it doesn't exist
if [[ ! -f "$BACKUP_FILE" ]]; then
    echo -e "${GREEN}[INFO] - Creating backup of original DNF configuration...${NO_COLOR}"
    if ! sudo cp "$DNF_CONF" "$BACKUP_FILE"; then
        echo -e "${RED}[ERROR] - Failed to create backup file${NO_COLOR}"
        exit 1
    fi
    echo -e "${GREEN}[INFO] - Backup created at $BACKUP_FILE${NO_COLOR}"
else
    echo -e "${ORANGE}[INFO] - Backup file already exists at $BACKUP_FILE${NO_COLOR}"
fi

# Function to add or update configuration
update_dnf_config() {
    local key=$1
    local value=$2
    
    # Check if setting already exists with the same value
    if grep -q "^${key}=${value}$" "$DNF_CONF"; then
        echo -e "${ORANGE}[INFO] - Setting ${key}=${value} already exists${NO_COLOR}"
        return 0
    fi
    
    if grep -q "^${key}=" "$DNF_CONF"; then
        # Update existing setting
        echo -e "${BLUE}[INFO] - Updating existing setting: ${key}=${value}${NO_COLOR}"
        if ! sudo sed -i "s/^${key}=.*/${key}=${value}/" "$DNF_CONF"; then
            echo -e "${RED}[ERROR] - Failed to update setting: ${key}${NO_COLOR}"
            return 1
        fi
    else
        # Add new setting
        echo -e "${GREEN}[INFO] - Adding new setting: ${key}=${value}${NO_COLOR}"
        if ! echo "${key}=${value}" | sudo tee -a "$DNF_CONF" > /dev/null; then
            echo -e "${RED}[ERROR] - Failed to add setting: ${key}${NO_COLOR}"
            return 1
        fi
    fi
}

echo -e "${GREEN}[INFO] - Starting DNF configuration optimization...${NO_COLOR}"

# Array of configurations to add/update
declare -A configs=(
    ["fastestmirror"]="True"
    ["max_parallel_downloads"]="10"
    ["defaultyes"]="True"
    ["keepcache"]="True"
    ["deltarpm"]="True"
)

# Counter for successful changes
changes_made=0
errors=0

# Add/Update DNF optimizations
for key in "${!configs[@]}"; do
    if update_dnf_config "$key" "${configs[$key]}"; then
        ((changes_made++))
    else
        ((errors++))
    fi
done

# Final status report
echo -e "\n${BLUE}[INFO] - Configuration Summary:${NO_COLOR}"
echo -e "${GREEN}Successfully processed configurations: $changes_made${NO_COLOR}"
if [ $errors -gt 0 ]; then
    echo -e "${RED}Errors encountered: $errors${NO_COLOR}"
fi

echo -e "\n${BLUE}[INFO] - Current DNF Configuration:${NO_COLOR}"
echo -e "${ORANGE}"
grep -E "^(fastestmirror|max_parallel_downloads|defaultyes|keepcache|deltarpm)=" "$DNF_CONF"
echo -e "${NO_COLOR}"

# Verify if changes were successful
if [ $errors -eq 0 ]; then
    echo -e "${GREEN}[SUCCESS] - DNF configuration has been optimized successfully${NO_COLOR}"
else
    echo -e "${RED}[WARNING] - DNF configuration completed with some errors${NO_COLOR}"
    exit 1
fi 