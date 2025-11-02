#!/bin/bash

THEME_COLOR="purple"
THEME_BACKGROUND="./configs/theme/background.png"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-$THEME_COLOR-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-$THEME_COLOR"
gsettings set org.gnome.desktop.interface accent-color "$THEME_COLOR" 2>/dev/null || true

BACKGROUND_DEST_DIR="$HOME/.local/share/backgrounds"
BACKGROUND_DEST_PATH="$BACKGROUND_DEST_DIR/$(basename $THEME_BACKGROUND)"

if [ ! -d "$BACKGROUND_DEST_DIR" ]; then mkdir -p "$BACKGROUND_DEST_DIR"; fi

[ ! -f $BACKGROUND_DEST_PATH ] && cp $THEME_BACKGROUND $BACKGROUND_DEST_PATH
gsettings set org.gnome.desktop.background picture-uri $BACKGROUND_DEST_PATH
gsettings set org.gnome.desktop.background picture-uri-dark $BACKGROUND_DEST_PATH
gsettings set org.gnome.desktop.background picture-options 'zoom'

# dconf load /org/gnome/terminal/ < ./configs/theme/tokyonight-gnome-terminal.txt
dconf write /org/gnome/Ptyxis/Profiles/`dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d \'`/palette "'Tokyo Night'"


# Set user image
busctl call org.freedesktop.Accounts /org/freedesktop/Accounts/User$UID org.freedesktop.Accounts.User SetIconFile s $PWD/configs/theme/avatar.png