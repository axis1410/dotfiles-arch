#!/bin/bash
# HyprShot.sh - Wrapper for hyprshot with notifications and sounds

# variables
time=$(date "+%d-%b_%H-%M-%S")
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"

iDIR="$HOME/.config/swaync/icons"
iDoR="$HOME/.config/swaync/images"
sDIR="$HOME/.config/hypr/scripts"

notify_cmd_base="notify-send -t 10000 -A action1=Open -A action2=Delete -h string:x-canonical-private-synchronous:shot-notify"
notify_cmd_shot="${notify_cmd_base} -i ${iDIR}/picture.png "
notify_cmd_NOT="notify-send -u low -i ${iDoR}/note.png "

# Make sure directory exists
if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
    local check_file="$1"
    if [[ -e "$check_file" ]]; then
        "${sDIR}/Sounds.sh" --screenshot
        resp=$(timeout 5 ${notify_cmd_shot} " Screenshot" " Saved")
        case "$resp" in
            action1)
                xdg-open "${check_file}" &
                ;;
            action2)
                rm "${check_file}" &
                ;;
        esac
    else
        ${notify_cmd_NOT} " Screenshot" " NOT Saved"
        "${sDIR}/Sounds.sh" --error
    fi
}

# Take screenshot based on mode
take_screenshot() {
    local mode="$1"
    local filepath="${dir}/${file}"
    
    case "$mode" in
        region)
            hyprshot -m region --output-folder "$dir" --filename "$file"
            ;;
        window)
            hyprshot -m window --output-folder "$dir" --filename "$file"
            ;;
        active)
            hyprshot -m window -m active --output-folder "$dir" --filename "$file"
            ;;
        output)
            hyprshot -m output --output-folder "$dir" --filename "$file"
            ;;
        *)
            echo "Unknown mode: $mode"
            return 1
            ;;
    esac
    
    # Sleep briefly to ensure file is saved
    sleep 0.5
    notify_view "$filepath"
}

# Handle countdown option
countdown() {
    for sec in $(seq $1 -1 1); do
        notify-send -h string:x-canonical-private-synchronous:shot-notify -t 1000 -i "$iDIR"/timer.png " Taking shot" " in: $sec secs"
        sleep 1
    done
}

# Parse arguments
case "$1" in
    --region)
        take_screenshot "region"
        ;;
    --window)
        take_screenshot "window"
        ;;
    --active)
        take_screenshot "active"
        ;;
    --output)
        take_screenshot "output"
        ;;
    --in5)
        countdown 5
        take_screenshot "region"
        ;;
    --in10)
        countdown 10
        take_screenshot "region"
        ;;
    *)
        echo -e "Available Options: --region --window --active --output --in5 --in10"
        exit 1
        ;;
esac

exit 0
