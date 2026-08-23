#!/data/data/com.termux/files/usr/bin/bash

# Color Palette (256-bit for premium look)
export BOLD='\033[1m'
export GREEN='\033[38;5;82m'
export RED='\033[38;5;196m'
export YELLOW='\033[38;5;226m'
export BLUE='\033[38;5;45m'
export CYAN='\033[38;5;51m'
export MAGENTA='\033[38;5;213m'
export WHITE='\033[38;5;255m'
export RESET='\033[0m'

# Icons
CHECK="${GREEN}✔${RESET}"
CROSS="${RED}✘${RESET}"
INFO="${BLUE}ℹ${RESET}"
STEP="${CYAN}➜${RESET}"
WAIT="${YELLOW}⏳${RESET}"

SILENT_MODE=false

while getopts "s" opt; do
  case $opt in
    s) SILENT_MODE=true ;;
    *) handle_error "Invalid option: -$OPTARG" ;;
  esac
done

# UI Helper Functions
draw_line() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

print_header() {
    draw_line
    echo -e "  ${BOLD}${WHITE}$1${RESET}"
    draw_line
}

handle_error() {
    echo -e "\n${RED}${BOLD}${CROSS} ERROR: $1${RESET}"
    exit 1
}

run_command() {
    local description="$1"
    local command="$2"

    if [ "$SILENT_MODE" = false ]; then
        echo -ne " ${STEP} ${WHITE}${description}...${RESET}"
    fi

    if eval "$command" > /dev/null 2>&1; then
        if [ "$SILENT_MODE" = false ]; then
            # \r moves cursor to start of line to overwrite the "Processing..." text
            echo -e "\r ${CHECK} ${GREEN}${description} completed!${RESET}      "
        fi
        return 0
    else
        echo -e "\r ${CROSS} ${RED}${description} failed!${RESET}      "
        handle_error "Failed to ${description,,}"
        return 1
    fi
}

display_logo() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo -e "   ┳┓┓        ┓┏┓┃  "
    echo -e "   ┣┫┣┓┏┓┏┓┃┏┓┃┃┃┃  "
    echo -e "   ┻┛┛┗┗┻┫┃┗┻┗┗┻┛┗  "
    echo -e "         ┛          "
    echo -e "    ${MAGENTA}Premium Repository Installer${RESET}"
    echo -e "    ${WHITE}Created by: ${YELLOW}@developerzarif${RESET}"
    echo ""
}

check_repo() {
    local repo_file="$1"
    local repo_name="$2"
    local pkg_name="$3"

    if [ -f "$PREFIX/etc/apt/sources.list.d/$repo_file" ]; then
        if [ "$SILENT_MODE" = false ]; then
            echo -e " ${CHECK} ${repo_name} is already configured."
        fi
    else
        if [ "$SILENT_MODE" = false ]; then
            echo -e " ${WAIT} Installing ${repo_name}..."
        fi
        if apt install "$pkg_name" -y > /dev/null 2>&1; then
            echo -e " ${CHECK} ${repo_name} installed successfully."
        else
            echo -e " ${CROSS} ${YELLOW}Warning: Could not install ${repo_name}.${RESET}"
        fi
    fi
}

# --- Main Execution ---

if [ "$SILENT_MODE" = false ]; then
    display_logo
    print_header "INITIALIZING SETUP"
    echo -e "${INFO} This script will configure the BanglaCLI"
    echo -e "  repository on your Termux environment."
    echo ""
fi

# Step 1: Checking Dependencies
check_repo "x11.list" "X11 Repository" "x11-repo"
check_repo "glibc.list" "Glibc Repository" "glibc-repo"

echo ""

# Step 2: Repository Configuration
run_command "Creating repository directory" "mkdir -p $PREFIX/etc/apt/sources.list.d"
run_command "Adding BanglaCLI source list" "echo 'deb [arch=all] https://termuxvoid.github.io/repo termuxvoid main' > $PREFIX/etc/apt/sources.list.d/termuxvoid.list"
run_command "Downloading security GPG key" "curl -sL https://github.com/termuxvoid/repo/raw/main/assets/termuxvoid.gpg -o $PREFIX/etc/apt/trusted.gpg.d/termuxvoid.gpg"
run_command "Updating package database" "apt update -y"

# Final Footer
echo ""
draw_line
echo -e "  ${GREEN}${BOLD}🎉 SUCCESS: Setup Completed Successfully! 🎉${RESET}"
draw_line
echo -e "\n${INFO} ${BOLD}You can now install packages from BanglaCLI.${RESET}"
echo -e "${INFO} Join our Telegram for tools and updates:"
echo -e "   ${BLUE}${BOLD}https://t.me/developerzarif${RESET}"
echo -e "\n${WHITE}Thank you for using BanglaCLI!${RESET}\n"
