#!/usr/bin/env bash
# ==============================================================
# ADB Toolkit - Bash Edition
# Coded by Cyber Security Engineer Mr Sabaz Ali Khan
# For authorized Android devices only.
# ==============================================================

set -u

APP_NAME="ADB Toolkit"
VERSION="1.0.0"
AUTHOR="Cyber Security Engineer Mr Sabaz Ali Khan"
WORKDIR="${HOME}/ADB-Toolkit"
SHOT_DIR="${WORKDIR}/screenshots"
RECORD_DIR="${WORKDIR}/recordings"
LOG_DIR="${WORKDIR}/logs"
PULL_DIR="${WORKDIR}/pulled_files"

mkdir -p "$SHOT_DIR" "$RECORD_DIR" "$LOG_DIR" "$PULL_DIR"

# ---------- Colors ----------
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
RESET='\033[0m'

banner() {
    clear 2>/dev/null || true
    printf "%b" "$CYAN"
    cat <<'BANNER'
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠉⠉⠉⠛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢻⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⢽⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⠀⠙⠻⣿⣿⣿⣿⣿⡃⠀⠀⢀⣴⣶⣿⣷⡦⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣷⣦⣤⣾⣿⣿⣿⡿⠃⣠⣴⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠈⠉⠻⣿⣿⣿⣿⣇⣼⠟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣄⣀⠀⠀⠀⣀⣠⣴⣶⡄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⣾⣿⣿⣷⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠘⠻⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⡛⠛⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢶⣾⣿⣿⣏⠛⠿⣿⣿⡿⠋⢉⣿⣿⣿⣿⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠘⣆⠀⠈⠛⠿⠿⠿⠃⠀⠀⠀⠀⠀⠙⠿⠛⠛⠁⠀⢠⡿⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠘⣧⠀⢀⣀⣀⣀⠀⠀⠸⠿⠆⠀⣀⣀⣠⣤⠀⢠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠈⢧⡀⢉⡛⠿⠿⠿⠶⠶⠾⠿⠿⠟⠋⠁⢠⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⣾⣿⣿⣷⣄⠀⠀⠀⢠⣤⣶⡆⣠⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⡿⠿⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⠀⠀⠀⢸⣿⣿⣷⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠛
⡿⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⡄⠀⠀⢸⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠇⠀⠀⠘⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
BANNER
    printf "%b\n" "$RESET"
    printf "%b%s v%s%b\n" "$GREEN" "$APP_NAME" "$VERSION" "$RESET"
    printf "%bCoded by %s%b\n" "$YELLOW" "$AUTHOR" "$RESET"
    printf "%bUse only on Android devices you own or are authorized to manage.%b\n\n" "$MAGENTA" "$RESET"
}

pause() {
    printf "\nPress Enter to continue..."
    read -r _
}

need_cmd() {
    command -v "$1" >/dev/null 2>&1
}

check_adb() {
    if ! need_cmd adb; then
        echo -e "${RED}[!] adb was not found.${RESET}"
        echo "Install Android platform-tools first."
        echo "Debian/Ubuntu/Kali: sudo apt update && sudo apt install adb -y"
        echo "Termux: pkg update && pkg install android-tools"
        exit 1
    fi
}

adb_serials() {
    adb devices | awk 'NR>1 && $2=="device" {print $1}'
}

choose_device() {
    mapfile -t DEVICES < <(adb_serials)
    local count=${#DEVICES[@]}

    if (( count == 0 )); then
        echo -e "${RED}[!] No authorized ADB device detected.${RESET}"
        echo "Enable Developer Options > USB debugging and accept the RSA prompt on the phone."
        return 1
    elif (( count == 1 )); then
        DEVICE="${DEVICES[0]}"
    else
        echo -e "${CYAN}Connected devices:${RESET}"
        local i
        for i in "${!DEVICES[@]}"; do
            printf "  %d) %s\n" "$((i+1))" "${DEVICES[$i]}"
        done
        read -rp "Select device number: " pick
        [[ "$pick" =~ ^[0-9]+$ ]] || { echo "Invalid selection."; return 1; }
        (( pick >= 1 && pick <= count )) || { echo "Invalid selection."; return 1; }
        DEVICE="${DEVICES[$((pick-1))]}"
    fi
    echo -e "${GREEN}[+] Selected: ${DEVICE}${RESET}"
}

adb_d() {
    adb -s "$DEVICE" "$@"
}

require_device() {
    choose_device || return 1
}

show_devices() {
    echo -e "${CYAN}ADB device list:${RESET}"
    adb devices -l
}

device_info() {
    require_device || return
    local brand model android sdk serial battery storage ip
    brand=$(adb_d shell getprop ro.product.manufacturer 2>/dev/null | tr -d '\r')
    model=$(adb_d shell getprop ro.product.model 2>/dev/null | tr -d '\r')
    android=$(adb_d shell getprop ro.build.version.release 2>/dev/null | tr -d '\r')
    sdk=$(adb_d shell getprop ro.build.version.sdk 2>/dev/null | tr -d '\r')
    serial=$(adb_d get-serialno 2>/dev/null | tr -d '\r')
    battery=$(adb_d shell dumpsys battery 2>/dev/null | awk -F': ' '/level:/ {print $2; exit}' | tr -d '\r')
    storage=$(adb_d shell df -h /data 2>/dev/null | tail -n 1 | tr -d '\r')
    ip=$(adb_d shell ip -f inet addr show wlan0 2>/dev/null | awk '/inet / {print $2; exit}' | tr -d '\r')

    echo -e "${GREEN}Device Information${RESET}"
    printf "Brand       : %s\n" "${brand:-Unknown}"
    printf "Model       : %s\n" "${model:-Unknown}"
    printf "Android     : %s\n" "${android:-Unknown}"
    printf "SDK         : %s\n" "${sdk:-Unknown}"
    printf "ADB Serial  : %s\n" "${serial:-Unknown}"
    printf "Battery     : %s%%\n" "${battery:-Unknown}"
    printf "Wi-Fi IP    : %s\n" "${ip:-Unavailable}"
    printf "Data storage: %s\n" "${storage:-Unavailable}"
}

list_packages() {
    require_device || return
    echo "1) User apps"
    echo "2) System apps"
    echo "3) All packages"
    read -rp "Choose: " mode
    case "$mode" in
        1) adb_d shell pm list packages -3 | sed 's/^package://' ;;
        2) adb_d shell pm list packages -s | sed 's/^package://' ;;
        3) adb_d shell pm list packages | sed 's/^package://' ;;
        *) echo "Invalid choice." ;;
    esac
}

install_apk() {
    require_device || return
    read -erp "Path to APK: " apk
    apk=${apk/#\~/$HOME}
    if [[ ! -f "$apk" ]]; then
        echo -e "${RED}[!] APK not found.${RESET}"
        return
    fi
    echo -e "${CYAN}Installing APK...${RESET}"
    adb_d install -r "$apk"
}

uninstall_app() {
    require_device || return
    read -rp "Package name (example: com.example.app): " pkg
    [[ "$pkg" =~ ^[A-Za-z0-9._-]+$ ]] || { echo "Invalid package name."; return; }
    read -rp "Uninstall $pkg from selected device? [y/N]: " yes
    [[ "$yes" =~ ^[Yy]$ ]] || { echo "Cancelled."; return; }
    adb_d uninstall "$pkg"
}

push_file() {
    require_device || return
    read -erp "Local file/folder path: " local_path
    local_path=${local_path/#\~/$HOME}
    [[ -e "$local_path" ]] || { echo "Local path not found."; return; }
    read -rp "Remote Android destination (default /sdcard/Download/): " remote_path
    remote_path=${remote_path:-/sdcard/Download/}
    adb_d push "$local_path" "$remote_path"
}

pull_file() {
    require_device || return
    read -rp "Remote Android file/folder path: " remote_path
    [[ -n "$remote_path" ]] || { echo "Remote path is required."; return; }
    echo "Saving into: $PULL_DIR"
    adb_d pull "$remote_path" "$PULL_DIR/"
}

screenshot() {
    require_device || return
    local ts remote localfile
    ts=$(date +%Y%m%d_%H%M%S)
    remote="/sdcard/adb_toolkit_${ts}.png"
    localfile="$SHOT_DIR/screenshot_${ts}.png"
    adb_d shell screencap -p "$remote" && \
    adb_d pull "$remote" "$localfile" && \
    adb_d shell rm -f "$remote"
    [[ -f "$localfile" ]] && echo -e "${GREEN}[+] Saved: $localfile${RESET}"
}

screen_record() {
    require_device || return
    local secs ts remote localfile
    read -rp "Recording length in seconds (1-180, default 30): " secs
    secs=${secs:-30}
    [[ "$secs" =~ ^[0-9]+$ ]] || { echo "Invalid number."; return; }
    (( secs >= 1 && secs <= 180 )) || { echo "Choose 1-180 seconds."; return; }
    ts=$(date +%Y%m%d_%H%M%S)
    remote="/sdcard/adb_record_${ts}.mp4"
    localfile="$RECORD_DIR/screen_${ts}.mp4"
    echo -e "${CYAN}Recording for ${secs}s...${RESET}"
    adb_d shell screenrecord --time-limit "$secs" "$remote"
    adb_d pull "$remote" "$localfile" && adb_d shell rm -f "$remote"
    [[ -f "$localfile" ]] && echo -e "${GREEN}[+] Saved: $localfile${RESET}"
}

capture_logcat() {
    require_device || return
    local secs ts outfile
    read -rp "Capture duration in seconds (default 20): " secs
    secs=${secs:-20}
    [[ "$secs" =~ ^[0-9]+$ ]] || { echo "Invalid number."; return; }
    (( secs >= 1 && secs <= 300 )) || { echo "Choose 1-300 seconds."; return; }
    ts=$(date +%Y%m%d_%H%M%S)
    outfile="$LOG_DIR/logcat_${ts}.txt"
    echo -e "${CYAN}Capturing logcat for ${secs}s...${RESET}"
    if need_cmd timeout; then
        timeout "$secs" adb -s "$DEVICE" logcat -v time > "$outfile" 2>&1 || true
    else
        adb -s "$DEVICE" logcat -d -v time > "$outfile" 2>&1 || true
    fi
    echo -e "${GREEN}[+] Saved: $outfile${RESET}"
}

battery_info() {
    require_device || return
    adb_d shell dumpsys battery
}

storage_info() {
    require_device || return
    adb_d shell df -h
}

network_info() {
    require_device || return
    echo -e "${CYAN}Interfaces:${RESET}"
    adb_d shell ip addr 2>/dev/null || adb_d shell ifconfig 2>/dev/null || true
    echo
    echo -e "${CYAN}Routing:${RESET}"
    adb_d shell ip route 2>/dev/null || true
}

open_shell() {
    require_device || return
    echo -e "${YELLOW}Opening interactive shell on authorized device. Type 'exit' to return.${RESET}"
    adb_d shell
}

reboot_menu() {
    require_device || return
    echo "1) Normal reboot"
    echo "2) Reboot to recovery"
    echo "3) Reboot to bootloader"
    echo "4) Cancel"
    read -rp "Choose: " r
    case "$r" in
        1) adb_d reboot ;;
        2) adb_d reboot recovery ;;
        3) adb_d reboot bootloader ;;
        *) echo "Cancelled." ;;
    esac
}

wifi_adb_help() {
    echo -e "${YELLOW}Wireless ADB helper (authorized device only)${RESET}"
    echo "Modern Android versions support Wireless debugging from Developer options."
    echo "Use Android's displayed pairing code/IP with these official adb commands:"
    echo "  adb pair IP:PAIR_PORT"
    echo "  adb connect IP:ADB_PORT"
    echo "  adb devices"
    echo
    echo "This toolkit does not scan for or connect to unknown devices."
}

save_report() {
    require_device || return
    local ts out
    ts=$(date +%Y%m%d_%H%M%S)
    out="$LOG_DIR/device_report_${ts}.txt"
    {
        echo "$APP_NAME $VERSION"
        echo "Coded by $AUTHOR"
        echo "Generated: $(date)"
        echo "Device: $DEVICE"
        echo
        echo "=== GETPROP ==="
        adb_d shell getprop
        echo
        echo "=== BATTERY ==="
        adb_d shell dumpsys battery
        echo
        echo "=== STORAGE ==="
        adb_d shell df -h
        echo
        echo "=== PACKAGES (USER) ==="
        adb_d shell pm list packages -3
    } > "$out" 2>&1
    echo -e "${GREEN}[+] Report saved: $out${RESET}"
}

restart_adb_server() {
    echo -e "${CYAN}Restarting ADB server...${RESET}"
    adb kill-server
    adb start-server
    adb devices -l
}

main_menu() {
    while true; do
        banner
        echo -e "${WHITE}1)  List connected devices"
        echo "2)  Device information"
        echo "3)  List installed packages"
        echo "4)  Install APK"
        echo "5)  Uninstall app"
        echo "6)  Push file/folder to Android"
        echo "7)  Pull file/folder from Android"
        echo "8)  Take screenshot"
        echo "9)  Record screen"
        echo "10) Capture logcat"
        echo "11) Battery information"
        echo "12) Storage information"
        echo "13) Network information"
        echo "14) Open ADB shell"
        echo "15) Reboot options"
        echo "16) Wireless ADB help"
        echo "17) Save device report"
        echo "18) Restart ADB server"
        echo -e "0)  Exit${RESET}"
        echo
        read -rp "Select option: " choice
        echo
        case "$choice" in
            1) show_devices ;;
            2) device_info ;;
            3) list_packages ;;
            4) install_apk ;;
            5) uninstall_app ;;
            6) push_file ;;
            7) pull_file ;;
            8) screenshot ;;
            9) screen_record ;;
            10) capture_logcat ;;
            11) battery_info ;;
            12) storage_info ;;
            13) network_info ;;
            14) open_shell ;;
            15) reboot_menu ;;
            16) wifi_adb_help ;;
            17) save_report ;;
            18) restart_adb_server ;;
            0) echo -e "${GREEN}Goodbye.${RESET}"; exit 0 ;;
            *) echo -e "${RED}Invalid option.${RESET}" ;;
        esac
        pause
    done
}

check_adb
main_menu
