#!/usr/bin/env bash

apply_wallpaper() {
    local uri="$1"
    # strip quotes, file:// prefix, url-decode %20 etc.
    local path
    path=$(printf '%s' "$uri" | sed -e "s/^'//" -e "s/'$//" -e 's#^file://##')
    path=$(printf '%b' "${path//%/\\x}")

    [ -f "$path" ] || return

    wal -i "$path" -n -q   # -n = skip setting wallpaper again, -q = quiet

    # kitty
    kill -SIGUSR1 $(pgrep -x kitty) 2>/dev/null

    # cava
    cp -f "$HOME/.cache/wal/cava-config" "$HOME/.config/cava/config" 2>/dev/null
    pkill -USR2 cava 2>/dev/null

    # yazi — only works if you've set up a wal template that outputs theme.toml
    if [ -f "$HOME/.cache/wal/theme.toml" ]; then
        cp -f "$HOME/.cache/wal/theme.toml" "$HOME/.config/yazi/theme.toml"
    fi

    # neovim
    nvr --remote-send '<Cmd>NeopywalCompile<CR>' 2>/dev/null || true
}

# --- prevent duplicate monitor instances ---
LOCKFILE="/tmp/wal-monitor.lock"
if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    exit 1
fi
trap 'rm -f "$LOCKFILE"' EXIT

# --- STEP 1: apply current wallpaper on boot ---
CURRENT_URI=$(gsettings get org.gnome.desktop.background picture-uri-dark)
if [ "$CURRENT_URI" = "''" ] || [ -z "$CURRENT_URI" ]; then
    CURRENT_URI=$(gsettings get org.gnome.desktop.background picture-uri)
fi
apply_wallpaper "$CURRENT_URI"

# --- STEP 2: watch for live changes, filtered to the uri keys ---
gsettings monitor org.gnome.desktop.background | while read -r line; do
    case "$line" in
        picture-uri-dark:*|picture-uri:*)
            uri="${line#*: }"
            apply_wallpaper "$uri"
            ;;
    esac
done
