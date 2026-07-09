#!/usr/bin/env bash

# --- STEP 1: Handle Current Wallpaper on Boot ---
CURRENT_URI=$(gsettings get org.gnome.desktop.background picture-uri-dark)
if [ "$CURRENT_URI" = "''" ] || [ -z "$CURRENT_URI" ]; then
    CURRENT_URI=$(gsettings get org.gnome.desktop.background picture-uri)
fi

if [ -f "$CURRENT_PATH" ]; then
    wal -i "$CURRENT_PATH"
    kill -SIGUSR1 $(pgrep -x kitty) 2>/dev/null
    nvr --remote-send '<Cmd>NeopywalCompile<CR>' 2>/dev/null || true
fi

# --- STEP 2: Rock-Solid Monitor Loop using dconf ---
# This listens explicitly to the background directory in GNOME's registry
dconf watch /org/gnome/desktop/background/ | while read -r path value; do
    # Check if the changed key is either picture-uri or picture-uri-dark
    if [[ "$path" == *"picture-uri"* ]]; then
        # Clean the string path out of the dconf value quotes
        
        if [ -n "$RAW_PATH" ] && [ -f "$RAW_PATH" ]; then
            wal -i "$RAW_PATH"
            kill -SIGUSR1 $(pgrep -x kitty) 2>/dev/null
            nvr --remote-send '<Cmd>NeopywalCompile<CR>' 2>/dev/null || true
        fi
    fi
done
