RED='\e[1;91m'
GREEN='\e[1;92m'
ORANGE='\e[1;93m'
NO_COLOR='\e[0m'

altTab() {
    echo -e "${BLUE}Configuring Alt+Tab window switching...${NO_COLOR}"
    
    # Set Alt+Tab to switch between windows
    echo -e "${GREEN}Setting Alt+Tab to switch between windows${NO_COLOR}"
    dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"

    # Set Alt+Shift+Tab to switch between windows backwards
    echo -e "${GREEN}Setting Alt+Shift+Tab to switch between windows backwards${NO_COLOR}"
    dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Alt><Shift>Tab']"

    # Disable application switching (we want window switching instead)
    echo -e "${ORANGE}Disabling application switching${NO_COLOR}"
    dconf write /org/gnome/desktop/wm/keybindings/switch-applications "['']"
    dconf write /org/gnome/desktop/wm/keybindings/switch-applications-backward "['']"

    echo -e "${GREEN}Alt+Tab configuration complete!${NO_COLOR}"
    
}