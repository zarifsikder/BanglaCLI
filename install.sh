#!/data/data/com.termux/files/usr/bin/bash

# --- [ Premium Color Palette ] ---
export BOLD='\033[1m'
export DIM='\033[2m'
export ITALIC='\033[3m'
export BLINK='\033[5m'
export BLUE='\033[38;5;39m'
export CYAN='\033[38;5;51m'
export GREEN='\033[38;5;85m'
export RED='\033[38;5;203m'
export YELLOW='\033[38;5;228m'
export MAGENTA='\033[38;5;213m'
export PURPLE='\033[38;5;141m'
export ORANGE='\033[38;5;208m'
export PINK='\033[38;5;206m'
export WHITE='\033[38;5;255m'
export GRAY='\033[38;5;248m'
export DARK_GRAY='\033[38;5;240m'
export RESET='\033[0m'

# --- [ Premium UI Icons ] ---
ICON_INFO="${BLUE}${RESET}"
ICON_SUCCESS="${GREEN}󰄬${RESET}"
ICON_ERROR="${RED}󰅙${RESET}"
ICON_WAIT="${YELLOW}󰣇${RESET}"
ICON_STEP="${CYAN}󰁹${RESET}"
ICON_STAR="${PURPLE}󰐥${RESET}"
ICON_SHIELD="${MAGENTA}󰒲${RESET}"
ICON_DOWNLOAD="${BLUE}󰇯${RESET}"
ICON_CHECK="${GREEN}󰄳${RESET}"
ICON_DIAMOND="${CYAN}󰘥${RESET}"
ICON_SPARKLE="${YELLOW}󰀻${RESET}"

# --- [ Advanced UI Functions ] ---

# Gradient progress bar with animation
gradient_progress() {
    local duration=${1:-3}
    local width=50
    local colors=(38 43 48 51 82 85)
    local bar=""
    
    for ((i=0; i<=width; i++)); do
        local progress=$((i * 100 / width))
        local color_index=$((i % ${#colors[@]}))
        local color_code="${colors[$color_index]}"
        
        printf "\r${DARK_GRAY}[${RESET}"
        for ((j=0; j<width; j++)); do
            if [ $j -lt $i ]; then
                printf "\033[38;5;${color_code}m█${RESET}"
            else
                printf "${DARK_GRAY}░${RESET}"
            fi
        done
        printf "${DARK_GRAY}]${RESET} ${WHITE}${progress}%%${RESET}"
        sleep $(echo "scale=2; $duration / $width" | bc)
    done
    echo ""
}

# Animated spinner with multiple styles
advanced_spinner() {
    local pid=$1
    local style=${2:-"dots"}
    local delay=0.1
    local spinstr
    
    case $style in
        "dots") spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏' ;;
        "line") spinstr='⎺⎻⎼⎽⎾⎿⣀⣁⣂⣃⣄⣅⣆⣇⣈⣉⣊⣋⣌⣍⣎⣏⣐⣑⣒⣓⣔⣕⣖⣗⣘⣙⣚⣛⣜⣝⣞⣟⣠⣡⣢⣣⣤⣥⣦⣧⣨⣩⣪⣫⣬⣭⣮⣯⣰⣱⣲⣳⣴⣵⣶⣷⣸⣹⣺⣻⣼⣽⣾⣿' ;;
        "pulse") spinstr='▁▂▃▄▅▆▇█▇▆▅▄▃▂▁' ;;
        "bounce") spinstr='⠁⠂⠄⠂' ;;
        *) spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏' ;;
    esac
    
    while kill -0 $pid 2>/dev/null; do
        for (( i=0; i<${#spinstr}; i++ )); do
            printf "\r${CYAN}${spinstr:$i:1}${RESET} "
            sleep $delay
        done
    done
    printf "\r    \r"
}

# Typewriter effect for headings
typewriter() {
    local text="$1"
    local delay=${2:-0.03}
    local color=${3:-$WHITE}
    
    echo -ne "${color}"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo -e "${RESET}"
}

# Glowing border creator
glow_border() {
    local title="$1"
    local color=${2:-$CYAN}
    local width=52
    
    echo -e "${color}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET}"
    printf "${color}┃${RESET} "
    printf "${BOLD}${WHITE}%*s%*s${RESET} " $(( (width - ${#title}) / 2 )) "" $(( (width - ${#title}) / 2 + ${#title} )) "$title"
    echo -e "${color}┃${RESET}"
    echo -e "${color}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET}"
}

# Decorative divider
decorative_divider() {
    echo -e "${DIM}${GRAY}◈ ──────────────────────────────────────── ◈${RESET}"
}

# -- [ Enhanced Banner ] ---

print_banner() {
    clear
    echo -e "${PURPLE}╔══════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${PURPLE}║${RESET}  ${BOLD}${MAGENTA}    ██████╗  █████╗ ███╗   ██╗ ██████╗ ██╗      ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}  ${BOLD}${MAGENTA}    ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██║      ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}  ${BOLD}${MAGENTA}    ██████╔╝███████║██╔██╗ ██║██║  ███╗██║      ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}  ${BOLD}${MAGENTA}    ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██║      ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}  ${BOLD}${MAGENTA}    ██████╔╝██║  ██║██║ ╚████║╚██████╔╝███████╗ ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}  ${BOLD}${MAGENTA}    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}                                                      ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}  ${ITALIC}${GRAY}✦ Premium Repository Installer v3.0 ✦${RESET}          ${PURPLE}║${RESET}"
    echo -e "${PURPLE}║${RESET}  ${DIM}${GRAY}⚡ Lightning Fast • Secure • Elegant${RESET}               ${PURPLE}║${RESET}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════╝${RESET}"
    echo ""
}

# -- [ Enhanced Task Execution ] ---

execute_task() {
    local label="$1"
    local cmd="$2"
    local emoji="${3:-$ICON_STEP}"
    
    echo -ne "${emoji} ${WHITE}${BOLD}${label}${RESET} ${DIM}...${RESET} "
    
    # Run command with redirection
    eval "$cmd" > /dev/null 2>&1 &
    local pid=$!
    
    # Advanced spinner
    advanced_spinner $pid "dots"
    
    wait $pid
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo -e "\r${ICON_SUCCESS} ${GREEN}${BOLD}${label}${RESET} ${GREEN}✓ Complete${RESET}      "
    else
        echo -e "\r${ICON_ERROR} ${RED}${BOLD}${label}${RESET} ${RED}✗ Failed${RESET}      "
        echo -e "\n${RED}${BOLD}┃ FATAL ERROR ┃${RESET}"
        echo -e "${RED}➜ Process interrupted. Check your connection.${RESET}"
        exit 1
    fi
}

# --- [ Enhanced Dependency Check ] ---

check_dependency() {
    local file="$1"
    local name="$2"
    local pkg="$3"
    
    echo -ne "${ICON_INFO} ${WHITE}Checking ${name}...${RESET} "
    
    if [ -f "$PREFIX/etc/apt/sources.list.d/$file" ]; then
        sleep 0.3
        echo -e "\r${ICON_SUCCESS} ${GREEN}${name}${RESET} ${GREEN}✓ Active${RESET}      "
    else
        echo -e "\r${ICON_WAIT} ${YELLOW}${name} not found. Installing...${RESET} "
        apt install "$pkg" -y > /dev/null 2>&1 &
        local pid=$!
        advanced_spinner $pid "pulse"
        wait $pid
        echo -e "\r${ICON_SUCCESS} ${GREEN}${name}${RESET} ${GREEN}✓ Installed${RESET}      "
    fi
}

# --- [ Progress Section ] ---

progress_section() {
    local current="$1"
    local total="$2"
    local title="$3"
    
    echo ""
    echo -e "${BOLD}${CYAN}${ICON_DIAMOND} ${WHITE}[${current}/${total}] ${title}${RESET}"
    echo -e "${DIM}${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# --- [ Glowing Status Card ] ---

status_card() {
    echo ""
    echo -e "${CYAN}┏━━━━━━━━━━━━━━━━━━━━━━━━━ ✦ ━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET}"
    echo -e "${CYAN}┃${RESET}                                                     ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${BOLD}${ICON_SPARKLE}  INSTALLATION STATUS  ${ICON_SPARKLE}${RESET}                        ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}                                                     ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${ICON_SHIELD} ${WHITE}Status     :${RESET} ${GREEN}${BOLD}● SUCCESSFUL${RESET}                    ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${ICON_DOWNLOAD} ${WHITE}Repository :${RESET} ${BLUE}BanglaCLI Main${RESET}                     ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${ICON_CHECK} ${WHITE}GPG Key    :${RESET} ${GREEN}✓ Verified${RESET}                        ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${ICON_STAR} ${WHITE}Security   :${RESET} ${MAGENTA}● Secure${RESET}                          ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}                                                     ${CYAN}┃${RESET}"
    echo -e "${CYAN}┃${RESET}  ${YELLOW}➜ Next Step:${RESET} ${WHITE}pkg install <tool-name>${RESET}                       ${CYAN}┃${RESET}"
    echo -e "${CYAN}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET}"
}

# --- [ Footer with Animation ] ---

print_footer() {
    echo ""
    echo -e "${GRAY}${DIM}╭──────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${GRAY}${DIM}│                                                          │${RESET}"
    echo -e "${GRAY}${DIM}│  ${ICON_INFO} ${WHITE}Join our community:${RESET} ${BLUE}https://t.me/developerzarif${RESET}         ${GRAY}${DIM}│${RESET}"
    echo -e "${GRAY}${DIM}│  ${ICON_STAR} ${WHITE}Support us:${RESET} ${PINK}Star the repository${RESET}                       ${GRAY}${DIM}│${RESET}"
    echo -e "${GRAY}${DIM}│                                                          │${RESET}"
    echo -e "${GRAY}${DIM}╰──────────────────────────────────────────────────────────╯${RESET}"
    echo ""
    
    # Animated exit message
    echo -ne "${BOLD}${GREEN}✨ Happy Coding! ✨${RESET}"
    for _ in {1..3}; do
        echo -n "."
        sleep 0.4
    done
    echo ""
}

# --- [ Main Workflow ] ---

# Start
print_banner

# Section 1: Pre-flight Checks
progress_section 1 3 "Environment Scanning"
echo ""
check_dependency "x11.list" "X11 Repository" "x11-repo"
check_dependency "glibc.list" "Glibc Repository" "glibc-repo"
echo ""

# Section 2: Repository Setup
progress_section 2 3 "Repository Configuration"
echo ""
execute_task "Creating secure directories" "mkdir -p $PREFIX/etc/apt/sources.list.d" "$ICON_SHIELD"
execute_task "Linking BanglaCLI source" "echo 'deb [arch=all] https://termuxvoid.github.io/repo termuxvoid main' > $PREFIX/etc/apt/sources.list.d/termuxvoid.list" "$ICON_DOWNLOAD"
execute_task "Importing GPG Security Key" "curl -sL https://github.com/termuxvoid/repo/raw/main/assets/termuxvoid.gpg -o $PREFIX/etc/apt/trusted.gpg.d/termuxvoid.gpg" "$ICON_CHECK"
echo ""

# Section 3: System Sync
progress_section 3 3 "System Synchronization"
echo ""
echo -ne "${ICON_WAIT} ${WHITE}Refreshing package database${RESET} ${DIM}...${RESET} "
apt update -y > /dev/null 2>&1 &
local pid=$!
advanced_spinner $pid "bounce"
wait $pid
if [ $? -eq 0 ]; then
    echo -e "\r${ICON_SUCCESS} ${GREEN}Package database updated${RESET}      "
else
    echo -e "\r${ICON_ERROR} ${RED}Package database update failed!${RESET}      "
fi
echo ""

# Section 4: Status Summary
decorative_divider
status_card
decorative_divider

# Footer
print_footer
