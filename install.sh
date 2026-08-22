#!/data/data/com.termux/files/usr/bin/bash

# --- Color Definitions ---
G='\e[1;32m' # Green
R='\e[1;31m' # Red
Y='\e[1;33m' # Yellow
B='\e[1;34m' # Blue
C='\e[1;36m' # Cyan
M='\e[1;35m' # Magenta
W='\e[1;37m' # White
RESET='\e[0m'

# --- Icons ---
CHECK="${G}✔${RESET}"
CROSS="${R}✘${RESET}"
INFO="${C}ⓘ${RESET}"
ARROW="${Y}➜${RESET}"
LINE="${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

SILENT_MODE=false

# --- Handle Options ---
while getopts "s" opt; do
  case $opt in
    s) SILENT_MODE=true ;;
    *) echo "Invalid option"; exit 1 ;;
  esac
done

# --- UI Helper Functions ---
print_header() {
    echo -e "${B}┌──────────────────────────────────────────────────┐${RESET}"
    printf "${B}│${W}  %-48s ${B}│\n" "$1"
    echo -e "${B}└──────────────────────────────────────────────────┘${RESET}"
}

display_logo() {
    clear
    echo -e "${C}"
    echo -e "  ____                    _         ____ _     ___ "
    echo -e " | __ )  __ _ _ __   __ _| | __ _  / ___| |   |_ _|"
    echo -e " |  _ \ / _\` | '_ \ / _\` | |/ _\` || |   | |    | | "
    echo -e " | |_) | (_| | | | | (_| | | (_| || |___| |___ | | "
    echo -e " |____/ \__,_|_| |_|\__, |_|\__,_| \____|_____|___|"
    echo -e "                    |___/                          "
    echo -e "${RESET}"
    echo -e "       ${M}⚡ BanglaCLI Repository Installer ⚡${RESET}"
    echo -e "${LINE}"
}

handle_error() {
    echo -e "\n${R}${CROSS} Error: $1${RESET}"
    exit 1
}

# Improved command runner with aligned status
run_step() {
    local desc="$1"
    local cmd="$2"

    if [ "$SILENT_MODE" = false ]; then
        printf " ${ARROW} %-40s " "${desc}..."
    fi

    if eval "$cmd" > /dev/null 2>&1; then
        if [ "$SILENT_MODE" = false ]; then
            echo -e "[  ${CHECK}  ]"
        fi
        return 0
    else
        if [ "$SILENT_MODE" = false ]; then
            echo -e "[  ${CROSS}  ]"
        fi
        handle_error "Failed to ${desc,,}"
        return 1
    fi
}

check_dependency_repo() {
    local name=$1
    local pkg=$2
    local file=$3

    if [ -f "$PREFIX/etc/apt/sources.list.d/$file" ]; then
        if [ "$SILENT_MODE" = false ]; then
            echo -e " ${CHECK} ${G}${name}${W} is already configured.${RESET}"
        fi
    else
        run_step "Installing ${name}" "apt install ${pkg} -y"
    fi
}

# --- Execution Flow ---

if [ "$SILENT_MODE" = false ]; then
    display_logo
    echo -e "${INFO} ${W}Initializing system setup...${RESET}"
    echo -e "${LINE}"
fi

# 1. Dependency Checks
check_dependency_repo "X11 Repository" "x11-repo" "x11.list"
check_dependency_repo "Glibc Repository" "glibc-repo" "glibc.list"

if [ "$SILENT_MODE" = false ]; then echo -e "${LINE}"; fi

# 2. Repository Configuration
run_step "Creating config directory" "mkdir -p $PREFIX/etc/apt/sources.list.d"

run_step "Adding BanglaCLI source" "echo 'deb [arch=all] https://termuxvoid.github.io/repo BanglaCLI main' > $PREFIX/etc/apt/sources.list.d/termuxvoid.list"

run_step "Importing GPG Security Key" "curl -sL https://github.com/zarifsikder/BanglaCLI/raw/main/assets/BanglaCLI.gpg -o $PREFIX/etc/apt/trusted.gpg.d/termuxvoid.gpg"

run_step "Refreshing package lists" "apt update -y"

# 3. Finalization
if [ "$SILENT_MODE" = false ]; then
    echo -e "${LINE}"
    print_header "SETUP COMPLETED SUCCESSFULLY"
    echo -e "\n${INFO} ${W}You can now install packages from the repository."
    echo -e "${INFO} ${W}Try: ${C}apt install <package-name>${RESET}"
    echo -e "${INFO} ${Y}Thank you for choosing BanglaCLI!${RESET}\n"
fi
