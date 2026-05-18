# ------------------------------------------------------------------------------
# MEND - The Distro-Agnostic Linux Command Assistant
# Version: 0.8.3
# Descriptions:
# mend -s hardware scanner
# Parses system hardware, translates generic IDs to distro-specific packages, 
# and provides an interactive FZF selection for installation.
#
# Author:  Rakosn1cek (https://github.com/Rakosn1cek/mend)
#
# This code is the original work of Lukas Grumlik - (Rakosn1cek). Attribution is required.
# License: MIT
# ------------------------------------------------------------------------------

# 1. Distro-specific package translator
mend_get_pkg_name() {
    local key="$1"
    
    case "$MEND_PM" in
        pacman)
            case "$key" in
                generic-nvidia) echo "nvidia-dkms" ;;
                generic-amd-gpu) echo "mesa" ;;
                generic-intel-graphics) echo "mesa" ;;
                generic-intel-wifi) echo "iwlwifi-db" ;;
                generic-rtl8822be) echo "rtl8822be-dkms" ;;
                generic-realtek-ethernet) echo "r8168" ;;
                generic-intel-ethernet) echo "linux-firmware" ;;
                generic-intel-audio) echo "sof-firmware" ;;
                generic-realtek-audio) echo "alsa-utils" ;;
                generic-amd-audio) echo "sof-firmware" ;;
                generic-usb-controller) echo "usbutils" ;;
                generic-realtek-bluetooth) echo "bluez" ;;
                generic-i2c-controller) echo "i2c-tools" ;;
                generic-rtw89) echo "rtw89-dkms-git" ;;
            esac
            ;;
        apt)
            case "$key" in
                generic-nvidia) echo "nvidia-driver" ;;
                generic-amd-gpu) echo "mesa-vulkan-drivers" ;;
                generic-intel-graphics) echo "intel-media-va-driver" ;;
                generic-intel-wifi) echo "firmware-iwlwifi" ;;
                generic-rtl8822be) echo "rtl8822be-dkms" ;;
                generic-realtek-ethernet) echo "r8168-dkms" ;;
                generic-intel-ethernet) echo "firmware-linux" ;;
                generic-intel-audio) echo "firmware-sof-signed" ;;
                generic-realtek-audio) echo "alsa-utils" ;;
                generic-amd-audio) echo "firmware-sof-signed" ;;
                generic-usb-controller) echo "usbutils" ;;
                generic-realtek-bluetooth) echo "bluez" ;;
                generic-i2c-controller) echo "i2c-tools" ;;
                generic-rtw89) echo "rtw89-dkms" ;;
            esac
            ;;
        dnf)
            case "$key" in
                generic-nvidia) echo "akmod-nvidia" ;;
                generic-amd-gpu) echo "mesa-dri-drivers" ;;
                generic-intel-graphics) echo "intel-media-driver" ;;
                generic-intel-wifi) echo "iwlwifi-firmware" ;;
                generic-rtl8822be) echo "rtl8822be-kmod" ;;
                generic-realtek-ethernet) echo "r8168" ;;
                generic-intel-ethernet) echo "linux-firmware" ;;
                generic-intel-audio) echo "sof-firmware" ;;
                generic-realtek-audio) echo "alsa-utils" ;;
                generic-amd-audio) echo "sof-firmware" ;;
                generic-usb-controller) echo "usbutils" ;;
                generic-realtek-bluetooth) echo "bluez" ;;
                generic-i2c-controller) echo "i2c-tools" ;;
                generic-rtw89) echo "rtw89" ;;
            esac
            ;;
        zypper)
            case "$key" in
                generic-nvidia) echo "nvidia-gfxG06-kmp-default" ;;
                generic-amd-gpu) echo "Mesa-dri" ;;
                generic-intel-graphics) echo "intel-vaapi-driver" ;;
                generic-intel-wifi) echo "kernel-firmware-iwlwifi" ;;
                generic-rtl8822be) echo "rtl8822be-kmp-default" ;;
                generic-realtek-ethernet) echo "r8168-kmp-default" ;;
                generic-intel-ethernet) echo "kernel-firmware-network" ;;
                generic-intel-audio) echo "kernel-firmware-audio" ;;
                generic-realtek-audio) echo "alsa-utils" ;;
                generic-amd-audio) echo "kernel-firmware-audio" ;;
                generic-usb-controller) echo "usbutils" ;;
                generic-realtek-bluetooth) echo "bluez" ;;
                generic-i2c-controller) echo "i2c-tools" ;;
                generic-rtw89) echo "rtw89-kmp-default" ;;
            esac
            ;;
    esac
}

# 2. Main Hardware Scanner
mend_scan_hardware() {
    local db_file="$MEND_DATA_DIR/hardware.db"
    
    if [[ ! -f "$db_file" ]]; then
        print -P "%F{red}Mend:%f Database file not found at $db_file"
        return 1
    fi

    local options=()
    
    # Get unique PCI IDs
    while read -r pci_id; do
        local match=$(grep "\[$pci_id\]" "$db_file")
        
        if [[ -n "$match" ]]; then
            local key=$(echo "$match" | cut -d'|' -f2 | tr -d ' ')
            local desc=$(echo "$match" | cut -d'|' -f3 | tr -d ' ')
            local pkg=$(mend_get_pkg_name "$key")
            
            if [[ -n "$pkg" ]]; then
                options+=("$desc | $pkg")
            fi
        fi
    done < <(lspci -nn | grep -E 'VGA|3D|Network|Ethernet|Audio|USB' | grep -oP '\[\K[0-9a-f]{4}:[0-9a-f]{4}(?=\])' | sort -u)

    if [[ ${#options[@]} -eq 0 ]]; then
        print -P "%F{yellow}Mend:%f No matching or supported hardware found."
        return 0
    fi

    # 3. Interactive FZF Selection
    local selection=$(printf "%s\n" "${options[@]}" | fzf --height 40% --layout=reverse --border \
        --header "Mend: Select driver/package to install" \
        --delimiter="|" \
        --preview "pkg={2}; tr -d ' ' <<< \"\$pkg\" | xargs -I{} sh -c \"$PM_INFO {} 2>/dev/null || [[ -n '$PM_HELPER' ]] && $PM_HELPER -Si {} 2>/dev/null || echo 'No info available'\"")

    # 4. Action
    if [[ -n "$selection" ]]; then
        local pkg=$(echo "$selection" | cut -d'|' -f2 | tr -d ' ')
        print -P "\n%F{green}Mend:%f Preparing to install %F{cyan}$pkg%f..."
        print -z "$PM_INSTALL $pkg"
    fi
}
