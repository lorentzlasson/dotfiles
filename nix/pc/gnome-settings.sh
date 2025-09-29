#!/usr/bin/env bash

# GNOME Settings Script
# This script configures GNOME settings via gsettings

# Dark theme
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Disable window tabbing (useless)
gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "[]"

# Tab between applications on alt tab (grouped by application type, not window)
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Alt>Tab']"

# Tab between windows of applications on alt backspace
gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Alt>BackSpace']"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "['<Shift><Alt>BackSpace']"

# Swap caps lock and escape
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"

# Custom terminal keybinding
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>t'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'alacritty'

# Workspace settings
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1

echo "GNOME settings applied"