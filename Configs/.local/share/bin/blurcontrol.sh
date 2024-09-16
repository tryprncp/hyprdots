#!/bin/env sh

# Path to config
file_path="${HOME}/.config/hypr/hyprland.conf"

# Toggle comment/uncomment for source line to blur/unblur hyprland
perl -i -pe 's|^(#\s*)?(source\s*=\s*~/.config/hypr/windowrules_blur\.conf)|$1 ? "$2" : "# $2"|e' "$file_path"
