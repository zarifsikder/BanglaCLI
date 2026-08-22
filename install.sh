#!/usr/bin/env bash

# --- Enhanced Modern UI Config ---
# Colors (256-color support)
CYAN='\033[38;5;51m'
MAGENTA='\033[38;5;201m'
GOLD='\033[38;5;220m'
GREEN='\033[38;5;82m'
RED='\033[38;5;196m'
WHITE='\033[38;5;231m'
GRAY='\033[38;5;244m'
RESET='\033[0m'
BOLD='\033[1m'

# Icons
I_INFO="󰋽"    # Info
I_SUCC="󰄬"    # Success
I_ERR="󰅖"     # Error
I_STEP="󰁕"    # Step
I_REPO="󰋚"    # Repository

# --- Global States ---
SILENT_MODE=false
STATUS_X11="Pending"
STATUS_GLIBC="Pending"
STATUS_BANGLA="Pending"
STATUS_GPG="Pending"

# --- UI Components ---

# Clean exit handler
cleanup() {
    tput cnorm # Show cursor
    echo -e "${RESET}"
}
trap cleanup EXIT

hide_cursor() { tput civis; }

print_banner() {
    clear
    echo -e "${MAGENTA}${BOLD}"
    echo -e "   ▄▄▄▄▀ ▄███▄      ▄      ▄▄▄▄▀ █    ██      ▄   "
    echo -e "▀▀▀ █    █▀   ▀      █  ▀▀▀ █    █    █ █      █  "
    echo -e "    █    ██▄▄    ██   █     █    █    █▄▄█ ██   █ "
    echo -e "   █     █▄   ▄▀ █ █  █    █     ███▄ █  █ █ █  █ "
    echo -e "  ▀      ▀███▀   █  █ █   ▀          ▀   █ █  █ █ "
    echo -e "                 █   ██                  █ █   ██ "
    echo -e " ${RESET}${CYAN}         Premium Repository Management Tool${RESET}"
    echo -e "${GRAY}──────────────────────────────────────────────────────${RESET}"
}

# Advanced Spinner Logic
# Usage: execute_task "Message" "command"
execute_task() {
    local msg="$1"
    local cmd="$2"
    local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local spin_color=$GOLD
    
    # Start command in background
    eval "$cmd" > /dev/null 2>&1 &
    local pid=$!

    if [ "$SILENT_MODE" = false ]; then
        printf "  ${spin_color}⠋${RESET} ${WHITE}%-40s" "$msg"
        local i=0
        while kill -0 $pid 2>/dev/null; do
            i=$(( (i+1) % 10 ))
            printf "\r  ${spin_color}${frames[$i]}${RESET} ${WHITE}%-40s" "$msg"
            sleep 0.08
        done
        
        # Check exit status
        wait $pid
        if [ $? -eq 0 ]; then
            printf "\r  ${GREEN}${I_SUCC}${RESET} ${WHITE}%-40s [ ${GREEN}DONE${RESET} ]\n" "$msg"
            return 0
        else
            printf "\r  ${RED}${I_ERR}${RESET} ${WHITE}%-40s [ ${RED}FAIL${RESET} ]\n" "$msg"
            return 1
        fi
    else
        wait $pid
        return $?
    fi
}

# --- Core Logic Functions ---

check_x11() {
    if [ -f "$PREFIX/etc/apt/sources.list.d/x11.list" ]; then
        STATUS_X11="${GREEN}Installed${RESET}"
        return 0
    fi
    if execute_task "Installing X11 Repository" "apt install x11-repo -y"; then
        STATUS_X11="${GREEN}Installed${RESET}"
    else
        STATUS_X11="${RED}Failed${RESET}"
    fi
}

check_glibc() {
    if [ -f "$PREFIX/etc/apt/sources.list.d/glibc.list" ]; then
        STATUS_GLIBC="${GREEN}Installed${RESET}"
        return 0
    fi
    if execute_task "Installing Glibc Repository" "apt install glibc-repo -y"; then
        STATUS_GLIBC="${GREEN}Installed${RESET}"
    else
        STATUS_GLIBC="${RED}Failed${RESET}"
    fi
}

# --- Main Flow ---

while getopts "s" opt; do
  case $opt in
    s) SILENT_MODE=true ;;
    *) echo "Invalid option"; exit 1 ;;
  esac
done

hide_cursor
print_banner

echo -e "\n${BOLD}${I_INFO} SYSTEM INITIALIZATION${RESET}"
echo -e "${GRAY}Checking environment dependencies...${RESET}\n"

# Step 1: Pre-requisites
check_x11
check_glibc

# Step 2: BanglaCLI Configuration
echo -e "\n${BOLD}${I_REPO} REPOSITORY SETUP${RESET}"

if execute_task "Syncing Source Lists" "mkdir -p $PREFIX/etc/apt/sources.list.d && echo 'deb [arch=all] https://termuxvoid.github.io/repo BanglaCLI main' > $PREFIX/etc/apt/sources.list.d/termuxvoid.list"; then
    STATUS_BANGLA="${GREEN}Configured${RESET}"
else
    STATUS_BANGLA="${RED}Error${RESET}"
fi

if execute_task "Fetching Security GPG Key" "curl -sL https://github.com/zarifsikder/BanglaCLI/raw/main/assets/BanglaCLI.gpg -o $PREFIX/etc/apt/trusted.gpg.d/termuxvoid.gpg"; then
    STATUS_GPG="${GREEN}Secured${RESET}"
else
    STATUS_GPG="${RED}Failed${RESET}"
fi

# Step 3: Final Sync
echo -e ""
execute_task "Updating Package Database" "apt update -y"

# --- Final Dashboard UI ---
echo -e "\n${GRAY}──────────────────────────────────────────────────────${RESET}"
echo -e " ${BOLD}${GOLD}INSTALLATION SUMMARY${RESET}"
echo -e " ${GRAY}────────────────────${RESET}"
printf " │ %-25s : %b\n" "X11 Infrastructure" "$STATUS_X11"
printf " │ %-25s : %b\n" "Glibc Library" "$STATUS_GLIBC"
printf " │ %-25s : %b\n" "BanglaCLI Source" "$STATUS_BANGLA"
printf " │ %-25s : %b\n" "GPG Authentication" "$STATUS_GPG"
echo -e "${GRAY}──────────────────────────────────────────────────────${RESET}"

echo -e "\n ${GREEN}${BOLD}SUCCESS:${RESET} Setup complete. Enjoy your premium experience!"
echo -e " ${CYAN}${I_STEP} Next:${RESET} Try running ${BOLD}apt install <package>${RESET}\n"
