#!/data/data/com.termux/files/usr/bin/bash

# =============================================
#   🌿 BANGLACLI REPOSITORY INSTALLER v2.0
#   Premium Green UI/UX Design
# =============================================

# --- Color Palette (Green Theme) ---
readonly RESET='\e[0m'
readonly BOLD='\e[1m'
readonly DIM='\e[2m'

# Green Shades
readonly GREEN_DARK='\e[38;2;0;100;0m'          # Dark Green
readonly GREEN_PRIMARY='\e[38;2;34;139;34m'     # Forest Green
readonly GREEN_MEDIUM='\e[38;2;0;150;0m'        # Medium Green
readonly GREEN_BRIGHT='\e[38;2;0;200;0m'        # Bright Green
readonly GREEN_LIGHT='\e[38;2;144;238;144m'     # Light Green
readonly GREEN_PALE='\e[38;2;152;251;152m'      # Pale Green
readonly GREEN_NEON='\e[38;2;57;255;20m'        # Neon Green
readonly GREEN_MINT='\e[38;2;152;255;152m'      # Mint Green
readonly GREEN_OLIVE='\e[38;2;107;142;35m'      # Olive Green

# Accent Colors (Green Theme)
readonly SUCCESS="${GREEN_BRIGHT}"
readonly ERROR='\e[38;2;255;100;100m'          # Soft Red for errors
readonly WARNING='\e[38;2;255;200;50m'          # Yellow for warnings
readonly INFO="${GREEN_LIGHT}"
readonly ACCENT="${GREEN_NEON}"

# Gradients (Green to Mint)
readonly GRADIENT_START="${GREEN_PRIMARY}"
readonly GRADIENT_END="${GREEN_MINT}"

# --- Icons & Symbols (Green Themed) ---
readonly ICON_CHECK="${GREEN_BRIGHT}◆${RESET}"
readonly ICON_CROSS="${ERROR}◆${RESET}"
readonly ICON_INFO="${GREEN_LIGHT}●${RESET}"
readonly ICON_ARROW="${GREEN_NEON}▸${RESET}"
readonly ICON_STAR="${GREEN_NEON}★${RESET}"
readonly ICON_GEAR="${GREEN_PRIMARY}⚙${RESET}"
readonly ICON_DOWNLOAD="${GREEN_MEDIUM}⬇${RESET}"
readonly ICON_LOCK="${GREEN_DARK}🔒${RESET}"
readonly ICON_ROCKET="${GREEN_NEON}🚀${RESET}"
readonly ICON_SPARKLE="${GREEN_MINT}✨${RESET}"
readonly ICON_LEAF="${GREEN_BRIGHT}🌿${RESET}"
readonly ICON_TREE="${GREEN_DARK}🌳${RESET}"

# --- UI Elements ---
readonly LINE_FULL="${GREEN_PRIMARY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
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

# Green Gradient Text Generator
gradient_text() {
    local text="$1"
    local len=${#text}
    local output=""
    
    for ((i=0; i<len; i++)); do
        char="${text:i:1}"
        if [[ "$char" == " " ]]; then
            output+=" "
        else
            local intensity=$(( 34 + (i * 118 / len) ))
            local r=$(( 0 + (i * 57 / len) ))
            local g=$(( 139 + (i * 113 / len) ))
            local b=$(( 34 - (i * 34 / len) ))
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

# Progress Bar (Green)
progress_bar() {
    local current=$1
    local total=$2
    local width=40
    local percent=$(( current * 100 / total ))
    local filled=$(( percent * width / 100 ))
    local empty=$(( width - filled ))
    
    printf "\r${GREEN_NEON}▸${RESET} Progress: ["
    printf "${GREEN_BRIGHT}%${filled}s${RESET}" | tr ' ' '█'
    printf "${DIM}%${empty}s${RESET}" | tr ' ' '░'
    printf "] ${BOLD}%3d%%${RESET}" "$percent"
}

# Animated Header (Green)
display_header() {
    clear
    echo -e "${LINE_FULL}"
    echo -e "${GREEN_PRIMARY}${BOLD}   ██████╗  █████╗ ███╗   ██╗ ██████╗ ██╗      █████╗  ██████╗██╗${RESET}"
    echo -e "${GREEN_DARK}${BOLD}   ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██║     ██╔══██╗██╔════╝██║${RESET}"
    echo -e "${GREEN_PRIMARY}${BOLD}   ██████╔╝███████║██╔██╗ ██║██║  ███╗██║     ███████║██║     ██║${RESET}"
    echo -e "${GREEN_MEDIUM}${BOLD}   ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██║     ██╔══██║██║     ██║${RESET}"
    echo -e "${GREEN_BRIGHT}${BOLD}   ██████╔╝██║  ██║██║ ╚████║╚██████╔╝███████╗██║  ██║╚██████╗██║${RESET}"
    echo -e "${GREEN_NEON}${BOLD}   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝${RESET}"
    echo -e "${LINE_FULL}"
    echo -e "${GRADIENT_START}${BOLD}   ${ICON_LEAF}  Premium Green Repository Installer  ${ICON_LEAF}${RESET}"
    echo -e "${DIM}   ──────────────────────────────────────────────────────${RESET}"
    echo -e "${GREEN_LIGHT}   ${ICON_ROCKET} Version 2.0  ${ICON_LOCK} Secure  ${ICON_SPARKLE} Optimized${RESET}"
    echo -e "${LINE_FULL}"
}

# Box with rounded corners (Green)
rounded_box() {
    local title="$1"
    local content="$2"
    echo -e "${GREEN_PRIMARY}╭─────────────────────────────────────────────────────────────╮${RESET}"
    printf "${GREEN_PRIMARY}│${RESET} ${BOLD}${title}${RESET}\n"
    echo -e "${GREEN_PRIMARY}├─────────────────────────────────────────────────────────────┤${RESET}"
    echo -e "$content"
    echo -e "${GREEN_PRIMARY}╰─────────────────────────────────────────────────────────────╯${RESET}"
}

# Status Card (Green)
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
        progress_bar "$step_num" "$total_steps"
        echo ""
        echo -ne "${GREEN_PRIMARY}${BOLD}  ${ICON_GEAR}  ${desc}${RESET} "
    fi
    
    if eval "$cmd" > /dev/null 2>&1; then
        if [ "$SILENT_MODE" = false ]; then
            echo -e "${GREEN_BRIGHT}${BOLD}✓ DONE${RESET}"
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
        echo -ne "${GREEN_LIGHT}  ${ICON_INFO}  Checking ${BOLD}${name}${RESET}... "
    fi
    
    if [ -f "$PREFIX/etc/apt/sources.list.d/$file" ]; then
        if [ "$SILENT_MODE" = false ]; then
            echo -e "${GREEN_BRIGHT}${BOLD}✓ Already configured${RESET}"
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
        echo -e "\n${DIM}  ${ICON_LEAF} Initializing green system setup...${RESET}"
        sleep 0.5
    fi
    
    # =========================================
    #   STEP 1: DEPENDENCY CHECK
    # =========================================
    
    echo -e "\n${GREEN_NEON}${BOLD}  ──[ PHASE 1: DEPENDENCY CHECK ]─────────────────────${RESET}"
    echo -e "${DIM}  ${ICON_TREE} Preparing system environment...${RESET}\n"
    
    check_dependency "X11 Repository" "x11-repo" "x11.list"
    check_dependency "Glibc Repository" "glibc-repo" "glibc.list"
    
    if [ "$SILENT_MODE" = false ]; then
        echo -e "\n${GREEN_BRIGHT}  ${ICON_CHECK}  All dependencies satisfied ${ICON_LEAF}${RESET}"
        sleep 0.5
    fi
    
    # =========================================
    #   STEP 2: REPOSITORY CONFIGURATION
    # =========================================
    
    echo -e "\n${GREEN_MEDIUM}${BOLD}  ──[ PHASE 2: REPOSITORY SETUP ]────────────────────${RESET}"
    echo -e "${DIM}  ${ICON_TREE} Configuring BanglaCLI repository...${RESET}\n"
    
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
        echo -e "\n${GREEN_BRIGHT}${BOLD}╔═════════════════════════════════════════════════════════╗${RESET}"
        echo -e "${GREEN_NEON}${BOLD}║${RESET}  ${ICON_STAR}  ${BOLD}🌿 SETUP COMPLETED SUCCESSFULLY 🌿${RESET}"
        echo -e "${GREEN_BRIGHT}${BOLD}╚═════════════════════════════════════════════════════════╝${RESET}"
        
        echo -e "\n${GREEN_LIGHT}  ${ICON_INFO}  ${BOLD}Repository Ready!${RESET}"
        echo -e "${DIM}  ──────────────────────────────────────────────────────────${RESET}"
        echo -e "${GREEN_NEON}  ${ICON_ARROW}  Install packages with:${RESET}"
        echo -e "${GREEN_PRIMARY}     $ apt install ${BOLD}<package-name>${RESET}"
        echo -e "\n${GREEN_NEON}  ${ICON_ARROW}  Available packages:${RESET}"
        echo -e "${GREEN_PRIMARY}     $ apt search BanglaCLI${RESET}"
        echo -e "\n${DIM}  ──────────────────────────────────────────────────────────${RESET}"
        echo -e "${GREEN_BRIGHT}  ${ICON_LEAF}  Thank you for choosing BanglaCLI Green!${RESET}"
        echo -e "${DIM}  ${ICON_ROCKET}  Stay connected for updates ${ICON_TREE}${RESET}\n"
        
        # Green animation for completion
        echo -n "${GREEN_BRIGHT}  "
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
