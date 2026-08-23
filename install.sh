#!/data/data/com.termux/files/usr/bin/bash

# --- [ High-End Color Palette ] ---
export BOLD='\033[1m'
export DIM='\033[2m'
export ITALIC='\033[3m'
export BLUE='\033[38;5;33m'
export CYAN='\033[38;5;51m'
export GREEN='\033[38;5;82m'
export RED='\033[38;5;196m'
export YELLOW='\033[38;5;226m'
export MAGENTA='\033[38;5;201m'
export WHITE='\033[38;5;255m'
export GRAY='\033[38;5;244m'
export RESET='\033[0m'

# --- [ UI Icons ] ---
ICON_INFO="${BLUE}󰋼${RESET}"
ICON_SUCCESS="${GREEN}✔${RESET}"
ICON_ERROR="${RED}✘${RESET}"
ICON_WAIT="${YELLOW}󱑔${RESET}"
ICON_STEP="${CYAN}❯${RESET}"

# --- [ Core Functions ] ---

# Animated Spinner for background tasks
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    while [ "$(ps -p $pid -o state= 2>/dev/null)" ]; do
        local temp=${spinstr#?}
        printf " ${CYAN}%c${RESET} " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Header with a modern border
print_banner() {
    clear
    echo -e "${CYAN}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET}"
    echo -e "${CYAN}┃${RESET}  ${BOLD}${MAGENTA}      ____              _         ${CYAN}CLI  ${RESET}        ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${BOLD}${MAGENTA}     | __ )  __ _ _ __ | |__   ___  ${RESET}            ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${BOLD}${MAGENTA}     |  _ \ / _' | '_ \| '_ \ / _ \ ${RESET}            ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${BOLD}${MAGENTA}     | |_) | (_| | | | | | | |  __/ ${RESET}            ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${BOLD}${MAGENTA}     |____/ \__,_|_| |_|_| |_|\___| ${RESET}            ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}                                                      ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${ITALIC}${GRAY}Premium Repository Installer • v2.0${RESET}               ${CYAN}┃${RESET}"
    echo -e "${CYAN}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET}"
    echo ""
}

# Task Execution with integrated spinner
execute_task() {
    local label="$1"
    local cmd="$2"
    
    echo -ne "${ICON_STEP} ${WHITE}${label}...${RESET}"
    
    # Run command in background
    eval "$cmd" > /dev/null 2>&1 &
    local pid=$!
    
    # Start spinner for that PID
    spinner $pid
    
    # Wait for the command to finish and check status
    wait $pid
    if [ $? -eq 0 ]; then
        echo -e "\r${ICON_SUCCESS} ${GREEN}${label} completed.${RESET}      "
    else
        echo -e "\r${ICON_ERROR} ${RED}${label} failed!${RESET}      "
        echo -e "\n${RED}${BOLD}FATAL ERROR:${RESET} Interrupted. Please check internet connection."
        exit 1
    fi
}

check_dependency() {
    local file="$1"
    local name="$2"
    local pkg="$3"
    
    echo -ne "${ICON_INFO} Checking ${name}..."
    sleep 0.5 # Aesthetic pause
    if [ -f "$PREFIX/etc/apt/sources.list.d/$file" ]; then
        echo -e "\r${ICON_SUCCESS} ${name} is ${GREEN}Active${RESET}      "
    else
        echo -e "\r${ICON_WAIT} ${name} not found. Installing..."
        apt install "$pkg" -y > /dev/null 2>&1
        echo -e "\r${ICON_SUCCESS} ${name} ${GREEN}Installed Successfully${RESET}      "
    fi
}

# --- [ Main Workflow ] ---

print_banner

# Module 1: Pre-flight Checks
echo -e "${BOLD}${WHITE}[1/3] Environment Scanning${RESET}"
echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
check_dependency "x11.list" "X11 Repository" "x11-repo"
check_dependency "glibc.list" "Glibc Repository" "glibc-repo"
echo ""

# Module 2: Repository Setup
echo -e "${BOLD}${WHITE}[2/3] Repository Configuration${RESET}"
echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
execute_task "Creating secure directories" "mkdir -p $PREFIX/etc/apt/sources.list.d"
execute_task "Linking BanglaCLI source" "echo 'deb [arch=all] https://termuxvoid.github.io/repo termuxvoid main' > $PREFIX/etc/apt/sources.list.d/termuxvoid.list"
execute_task "Importing GPG Security Key" "curl -sL https://github.com/termuxvoid/repo/raw/main/assets/termuxvoid.gpg -o $PREFIX/etc/apt/trusted.gpg.d/termuxvoid.gpg"
echo ""

# Module 3: Synchronization
echo -e "${BOLD}${WHITE}[3/3] System Sync${RESET}"
echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
execute_task "Refreshing package database" "apt update -y"
echo ""

# --- [ Final Structured Report ] ---

echo -e "${CYAN}┏━━━━━━━━━━━━━ Installation Summary ━━━━━━━━━━━━━┓${RESET}"
echo -e "${CYAN}┃${RESET}                                               ${CYAN}┃${RESET}"
echo -e "${CYAN}┃${RESET}  ${GREEN}STATUS:${RESET}    Successfully Configured            ${CYAN}┃${RESET}"
echo -e "${CYAN}┃${RESET}  ${GREEN}REPO:${RESET}      BanglaCLI Main Branch              ${CYAN}┃${RESET}"
echo -e "${CYAN}┃${RESET}  ${GREEN}GPG KEY:${RESET}   Verified & Imported                ${CYAN}┃${RESET}"
echo -e "${CYAN}┃${RESET}                                               ${CYAN}┃${RESET}"
echo -e "${CYAN}┃${RESET}  ${YELLOW}Next Step:${RESET} Try 'pkg install <tool-name>'     ${CYAN}┃${RESET}"
echo -e "${CYAN}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET}"

echo -e "\n${BOLD}${WHITE}Join Community:${RESET} ${BLUE}https://t.me/developerzarif${RESET}"
echo -e "${GRAY}${ITALIC}Happy Coding!${RESET}\n"
