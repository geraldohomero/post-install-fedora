# Fedora 41 Post-Installation Script

This is a Bash script designed to automate the post-installation setup of Fedora. It installs essential software, enables necessary repositories, and configures the system for a smoother user experience.

## Features

- **System Updates**: Automatically updates the system and cleans up unnecessary packages.
- **RPM Fusion Repositories**: Enables both free and non-free RPM Fusion repositories.
- **Essential Software**: Installs popular tools and applications via `dnf` and `flatpak`.
- **Customizable**: Easily add or remove packages from the script to suit your needs.
- **Internet Check**: Verifies internet connectivity before proceeding.
- **Android SDK Setup**: Adds Android SDK to the system PATH for development purposes.

---
## Prerequisites

- A fresh installation of Fedora.
- Internet connection.
- Administrative privileges (sudo access).
---

## How to Use

1. **Download the Script**:
   - Clone this repository or download the script directly:
   ```bash
   git clone https://github.com/geraldohomero/post-install-fedora.git
   ```
2. **Make the Script Executable**:
   ```bash
   chmod +x run.sh
   ```
3. **Run the script**
   ```bash
   sudo ./run.sh
   ```

