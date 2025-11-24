#!/bin/sh
# config-menu.sh

config=$(echo -e "solitario\ngittype\nbotany\ndraw" | dmenu -i -vi -c -l 7 -p "Choose the game:")

case "$config" in
    "solitario") alacritty -e solitaire;;
    "gittype") alacritty -e gittype;;
    "botany") alacritty -e python ~/botany/botany.py;;
    "draw") alacritty -e draw;;
esac
