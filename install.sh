#!/data/data/com.termux/files/usr/bin/bash

# =============================================
#   🚀 BANGLACLI REPOSITORY INSTALLER v2.0
#   Premium UI/UX Design
# =============================================

# --- Color Palette ---
readonly RESET='\e[0m'
readonly BOLD='\e[1m'
readonly DIM='\e[2m'

# Primary Colors
readonly PRIMARY='\e[38;2;99;102;241m'      # Indigo
readonly SECONDARY='\e[38;2;236;72;153m'    # Pink
readonly ACCENT='\e[38;2;251;191;36m'       # Amber
readonly SUCCESS='\e[38;2;52;211;153m'      # Emerald
readonly ERROR='\e[38;2;248;113;113m'       # Red
readonly INFO='\e[38;2;96;165;250m'         # Blue
readonly WARNING='\e[38;2;251;146;60m'      # Orange

# Gradients for special elements
readonly GRADIENT_START='\e[38;2;99;102;241m'
readonly GRADIENT_END='\e[38;2;236;72;153m'

# --- Icons & Symbols ---
readonly ICON_CHECK="${SUCCESS}◆${RESET}"
readonly ICON_CROSS="${ERROR}◆${RESET}"
readonly ICON_INFO="${INFO}●${RESET}"
readonly ICON_ARROW="${ACCENT}▸${RESET}"
readonly ICON_STAR="${ACCENT}★${RESET}"
readonly ICON_GEAR="${PRIMARY}⚙${RESET}"
readonly ICON_DOWNLOAD="${SECONDARY}⬇${RESET}"
readonly ICON_LOCK="${PRIMARY}🔒${RESET}"
readonly ICON_ROCKET="${ACCENT}🚀${RESET}"
readonly ICON_SPARKLE="${SECONDARY}✨${RESET}"

# --- UI Elements ---
readonly LINE_FULL="${PRIMARY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
readonly LINE_THIN="${DIM}─────────────────────────────────────────────────────────────${RESET}"
readonly BOX_TOP="╭─────────────────────────────────────────────────────────────╮"
readonly BOX_BOTTOM="╰─────────────────────────────────────────────────────────────╯"

# --- Configuration ---
SILENT_MODE=false
ANIMATION_DELAY=0.05

# --- Handle Options ---
while getopts "s" opt; do
    case $opt in
        s) SILENT_MODE=true ;;
        *) echo -e "${ERROR}❌ Invalid option${RESET}"; exit 1 ;;
    esac
done

# =============================================
#   UI HELPER FUNCTIONS
# =============================================

# Gradient Text Generator
gradient_text() {
    local text="$1"
    local len=${#text}
    local output=""
    
    for ((i=0; i<len; i++)); do
        char="${text:i:1}"
        if [[ "$char" == " " ]]; then
            output+=" "
        else
            local intensity=$(( 99 + (i * 137 / len) ))
            local r=$(( 99 + (i * 137 / len) ))
            local g=$(( 102 + (i * 134 / len) ))
            local b=$(( 241 - (i * 169 / len) ))
            output+="\e[38;2;${r};${g};${b}m${char}${RESET}"
        fi
    done
    echo -e "$output"
}

# Centered Text
center_text() {
    local text="$1"
    local width=60
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%${padding}s%s%${padding}s\n" "" "$text" ""
}

# Animated Typing Effect
type_effect() {
    local text="$1"
    local delay="${2:-$ANIMATION_DELAY}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:i:1}"
        sleep "$delay"
    done
    echo
}

# Progress Bar
progress_bar() {
    local current=$1
    local total=$2
    local width=40
    local percent=$(( current * 100 / total ))
    local filled=$(( percent * width / 100 ))
    local empty=$(( width - filled ))
    
    printf "\r${PRIMARY}▸${RESET} Progress: ["
    printf "${SUCCESS}%${filled}s${RESET}" | tr ' ' '█'
    printf "${DIM}%${empty}s${RESET}" | tr ' ' '░'
    printf "] ${BOLD}%3d%%${RESET}" "$percent"
}

# Animated Header
display_header() {
    clear
    echo -e "${LINE_FULL}"
    echo -e "${PRIMARY}${BOLD}   ██████╗  █████╗ ███╗   ██╗ ██████╗ ██╗      █████╗  ██████╗██╗${RESET}"
    echo -e "${PRIMARY}${BOLD}   ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██║     ██╔══██╗██╔════╝██║${RESET}"
    echo -e "${SECONDARY}${BOLD}   ██████╔╝███████║██╔██╗ ██║██║  ███╗██║     ███████║██║     ██║${RESET}"
    echo -e "${SECONDARY}${BOLD}   ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██║     ██╔══██║██║     ██║${RESET}"
    echo -e "${ACCENT}${BOLD}   ██████╔╝██║  ██║██║ ╚████║╚██████╔╝███████╗██║  ██║╚██████╗██║${RESET}"
    echo -e "${ACCENT}${BOLD}   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝${RESET}"
    echo -e "${LINE_FULL}"
    echo -e "${GRADIENT_START}${BOLD}   ◆  Premium Repository Installer  ◆${RESET}"
    echo -e "${DIM}   ──────────────────────────────────────────────────────${RESET}"
    echo -e "${INFO}   ${ICON_ROCKET} Version 2.0  ${ICON_LOCK} Secure  ${ICON_SPARKLE} Optimized${RESET}"
    echo -e "${LINE_FULL}"
}

# Box with rounded corners
rounded_box() {
    local title="$1"
    local content="$2"
    echo -e "${PRIMARY}╭─────────────────────────────────────────────────────────────╮${RESET}"
    printf "${PRIMARY}│${RESET} ${BOLD}${title}${RESET}\n"
    echo -e "${PRIMARY}├─────────────────────────────────────────────────────────────┤${RESET}"
    echo -e "$content"
    echo -e "${PRIMARY}╰─────────────────────────────────────────────────────────────╯${RESET}"
}

# Status Card
status_card() {
    local status="$1"
    local message="$2"
    local icon="$3"
    local color="$4"
    
    echo -e "${color}┌─────────────────────────────────────────────────────────────┐${RESET}"
    printf "${color}│${RESET}  ${icon}  ${BOLD}${status}${RESET}\n"
    echo -e "${color}├─────────────────────────────────────────────────────────────┤${RESET}"
    echo -e "${color}│${RESET}  ${message}"
    echo -e "${color}└─────────────────────────────────────────────────────────────┘${RESET}"
}

# =============================================
#   CORE FUNCTIONS
# =============================================

handle_error() {
    echo -e "\n${ERROR}${BOLD}╔═════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${ERROR}${BOLD}║${RESET}  ${ICON_CROSS}  ${BOLD}ERROR OCCURRED${RESET}"
    echo -e "${ERROR}${BOLD}╚═════════════════════════════════════════════════════════╝${RESET}"
    echo -e "${ERROR}  ${BOLD}►${RESET} $1"
    echo -e "${DIM}  ──────────────────────────────────────────────────────────${RESET}"
    echo -e "${WARNING}  ${ICON_INFO}  Try running with ${BOLD}./installer.sh -s${RESET} for silent mode${RESET}\n"
    exit 1
}

# Enhanced Command Runner with Animation
run_step() {
    local desc="$1"
    local cmd="$2"
    local step_num="$3"
    local total_steps="$4"
    
    if [ "$SILENT_MODE" = false ]; then
        # Show progress bar
        progress_bar "$step_num" "$total_steps"
        echo ""
        
        # Animated step description
        echo -ne "${PRIMARY}${BOLD}  ${ICON_GEAR}  ${desc}${RESET} "
    fi
    
    if eval "$cmd" > /dev/null 2>&1; then
        if [ "$SILENT_MODE" = false ]; then
            echo -e "${SUCCESS}${BOLD}✓ DONE${RESET}"
        fi
        return 0
    else
        if [ "$SILENT_MODE" = false ]; then
            echo -e "${ERROR}${BOLD}✗ FAILED${RESET}"
        fi
        handle_error "Failed to ${desc,,}"
        return 1
    fi
}

# Check and Install Dependency
check_dependency() {
    local name="$1"
    local pkg="$2"
    local file="$3"
    
    if [ "$SILENT_MODE" = false ]; then
        echo -ne "${INFO}  ${ICON_INFO}  Checking ${BOLD}${name}${RESET}... "
    fi
    
    if [ -f "$PREFIX/etc/apt/sources.list.d/$file" ]; then
        if [ "$SILENT_MODE" = false ]; then
            echo -e "${SUCCESS}${BOLD}✓ Already configured${RESET}"
        fi
    else
        if [ "$SILENT_MODE" = false ]; then
            echo -e "${WARNING}${BOLD}↻ Installing...${RESET}"
        fi
        run_step "Installing ${name}" "apt install ${pkg} -y" "0" "0"
    fi
}

# =============================================
#   MAIN EXECUTION
# =============================================

main() {
    # Display Header
    display_header
    
    if [ "$SILENT_MODE" = false ]; then
        echo -e "\n${DIM}  Initializing system setup...${RESET}"
        sleep 0.5
    fi
    
    # =========================================
    #   STEP 1: DEPENDENCY CHECK
    # =========================================
    
    echo -e "\n${ACCENT}${BOLD}  ──[ PHASE 1: DEPENDENCY CHECK ]─────────────────────${RESET}"
    echo -e "${DIM}  Preparing system environment...${RESET}\n"
    
    check_dependency "X11 Repository" "x11-repo" "x11.list"
    check_dependency "Glibc Repository" "glibc-repo" "glibc.list"
    
    if [ "$SILENT_MODE" = false ]; then
        echo -e "\n${SUCCESS}  ${ICON_CHECK}  All dependencies satisfied${RESET}"
        sleep 0.5
    fi
    
    # =========================================
    #   STEP 2: REPOSITORY CONFIGURATION
    # =========================================
    
    echo -e "\n${SECONDARY}${BOLD}  ──[ PHASE 2: REPOSITORY SETUP ]────────────────────${RESET}"
    echo -e "${DIM}  Configuring BanglaCLI repository...${RESET}\n"
    
    local total_steps=4
    local current_step=0
    
    ((current_step++))
    run_step "Creating config directory" "mkdir -p $PREFIX/etc/apt/sources.list.d" "$current_step" "$total_steps"
    
    ((current_step++))
    run_step "Adding BanglaCLI source" "echo 'deb [arch=all] https://termuxvoid.github.io/repo BanglaCLI main' > $PREFIX/etc/apt/sources.list.d/termuxvoid.list" "$current_step" "$total_steps"
    
    ((current_step++))
    run_step "Importing GPG Security Key" "curl -sL https://github.com/zarifsikder/BanglaCLI/raw/main/assets/BanglaCLI.gpg -o $PREFIX/etc/apt/trusted.gpg.d/termuxvoid.gpg" "$current_step" "$total_steps"
    
    ((current_step++))
    run_step "Refreshing package lists" "apt update -y" "$current_step" "$total_steps"
    
    # =========================================
    #   STEP 3: FINALIZATION
    # =========================================
    
    if [ "$SILENT_MODE" = false ]; then
        echo -e "\n${SUCCESS}${BOLD}╔═════════════════════════════════════════════════════════╗${RESET}"
        echo -e "${SUCCESS}${BOLD}║${RESET}  ${ICON_STAR}  ${BOLD}SETUP COMPLETED SUCCESSFULLY  ${ICON_STAR}${RESET}"
        echo -e "${SUCCESS}${BOLD}╚═════════════════════════════════════════════════════════╝${RESET}"
        
        echo -e "\n${INFO}  ${ICON_INFO}  ${BOLD}Repository Ready!${RESET}"
        echo -e "${DIM}  ──────────────────────────────────────────────────────────${RESET}"
        echo -e "${ACCENT}  ${ICON_ARROW}  Install packages with:${RESET}"
        echo -e "${PRIMARY}     $ apt install ${BOLD}<package-name>${RESET}"
        echo -e "\n${ACCENT}  ${ICON_ARROW}  Available packages:${RESET}"
        echo -e "${PRIMARY}     $ apt search BanglaCLI${RESET}"
        echo -e "\n${DIM}  ──────────────────────────────────────────────────────────${RESET}"
        echo -e "${SECONDARY}  ${ICON_HEART}  Thank you for choosing BanglaCLI!${RESET}"
        echo -e "${DIM}  ${ICON_ROCKET}  Stay connected for updates${RESET}\n"
        
        # Small animation for completion
        echo -n "${SUCCESS}  "
        for i in {1..30}; do
            echo -n "▰"
            sleep 0.03
        done
        echo -e " ${BOLD}100%${RESET}\n"
    fi
}

# =============================================
#   SCRIPT EXECUTION
# =============================================

# Trap Ctrl+C
trap 'echo -e "\n${WARNING}${BOLD}  ✋ Operation cancelled by user${RESET}\n"; exit 0' INT

# Run Main Function
main

exit 0
