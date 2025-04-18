# Fedora Post-Installation Script

A comprehensive automation script for setting up a fresh Fedora 42 Workstation installation with essential software, configurations, and development tools.

>Note: The script was designed for Fedora 42 Workstation, but it may also work on other Fedora-based distributions. However, please be cautious and ensure compatibility before running it on other systems.

>Important: While the script aims to automate setup tasks, it's essential to review the code and understand what it does before running it on your machine. Ensure that you back up critical data before proceeding. The script provided is for educational purposes and comes with no warranty or support.

[Fedora 42 - Post Install](https://github.com/geraldohomero/post-install-fedora)

[Pop!_OS (22.04) - Post Install](https://github.com/geraldohomero/post-install-pop-os)

## Features

- 🔄 System Updates and Optimization
- 📦 Essential Software Installation (DNF & Flatpak)
- 🗂️ Enable RPM Fusion repositories
- 🛠️ Development Environment Setup
- 🔧 Custom Aliases Configuration
- 🔐 GitHub Integration
- 🎮 Gaming and Multimedia Support
- 🎯 Android Development Setup

## Directory Structure

```bash
post-install-fedora/
├── src/
│ ├── alias.sh # Custom shell aliases configuration
│ └── altTab.sh # Alt+Tab behavior configuration
│ ├── devEnv.sh # Development environment setup
│ ├── dnf-config.sh # DNF package manager optimization
│ ├── githubCloneAndConfig.sh # GitHub repository setup
│ ├── homeScript.sh # Home directory utilities setup for `misc` 
│ └── post-install.sh # Main installation script
├── misc/
│ ├── update.sh # System update utility
│ ├── syncthingStatus.sh # Syncthing status checker
│ └── swapAudio.sh # Audio channel swap utility
└── run.sh # Main execution script
```


## Script Descriptions

### Main Scripts

1. **run.sh**
   - Entry point for the installation process
   - Orchestrates the execution of all other scripts
   - Handles initial setup and permissions

2. **post-install.sh**
   - Manages software installation
   - Configures RPM Fusion repositories
   - Installs DNF and Flatpak packages
   - Sets up Android SDK environment

### Utility Scripts

3. **alias.sh**
   - Configures custom shell aliases
   - Creates and manages `.bash_aliases` file
   - Integrates with `.bashrc`

4. **dnf-config.sh**
   - Optimizes DNF package manager settings
   - Improves download speeds and package management
   - Creates backup of original configuration

5. **devEnv.sh**
   - Sets up development tools
   - Installs Node.js, NVM, and other dev packages

6. **githubCloneAndConfig.sh**
   - Configures GitHub CLI
   - Clones user repositories
   - Sets up Git global configuration

7. **altTab.sh**
   - Configures Alt+Tab behavior
   - Enables window previews for all open applications

8. **homeScript.sh**
   - Add update.sh, syncthingStatus.sh and swapAudio. to home directory

### Miscellaneous Utilities

7. **misc/update.sh**
   - System update utility
   - Handles DNF and Flatpak updates
   - Performs system cleanup

8. **misc/syncthingStatus.sh**
   - Checks Syncthing service status

9. **misc/swapAudio.sh**
   - Utility for swapping audio channels

## Customizing Aliases

The script includes several predefined aliases that you can customize. To modify them, edit the `CUSTOM_ALIASES` array in `src/alias.sh`:

```bash
CUSTOM_ALIASES=(
'alias ips="ip -c -br a"'
'alias his="history|grep"'
'alias ports="netstat -tulanp"'
# Add your custom aliases here
)
```
Common included aliases:
- `update`, `upd`, `up`: Run system updates `misc/update.sh`
- `ips`: Show IP addresses
- `his`: Search command history
- `ports`: Show network ports
- `swap`: Switch audio output
- `syncstatus`: Check Syncthing status `misc/syncThingStatus.sh`

## Customizing Package Installation

To modify which packages are installed, edit the arrays in `src/post-install.sh`:

1. DNF Packages:

```bash
PROGRAMS_TO_INSTALL_DNF=(
btop
vim
# Add/remove packages here
)
```


2. Flatpak Packages:

```bash
PROGRAMS_TO_INSTALL_FLATPAK=(
org.qbittorrent.qBittorrent
# Add/remove packages here
)
```

## Usage

1. Clone the repository:

```bash
git clone https://github.com/geraldohomero/post-install-fedora.git
```

2. Make the script executable:

```bash
chmod +x run.sh
```

3. Run the script:

```bash
sudo ./run.sh
```

## Prerequisites

- Fresh Fedora installation
- Internet connection
- Sudo privileges

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
