#!/bin/sh
# config-menu.sh

config=$(echo -e "i3 config\nvim config\nbash config\nPolybar config\nAlacritty config\nFastfetch config\ncambia palette" | dmenu -i -c +vi -l 7 -p "Configura:")

case "$config" in
    "i3 config") alacritty -e vim ~/.config/i3/config ;;
    "vim config") alacritty -e vim ~/.vimrc ;;
    "bash config") alacritty -e vim ~/.bashrc ;;
    "Polybar config") alacritty -e vim ~/.config/polybar/config.ini ;;
    "Alacritty config") alacritty -e vim ~/.config/alacritty/alacritty.toml ;;
    "fastfetch config") alacritty -e vim ~/.config/fastfetch/config.jsonc ;;
    "cambia palette") alacritty -e ~/.local/bin/switch-palette.sh ;;
esac
