#!/bin/sh
# config-menu.sh

config=$(echo -e "nmtui\ngophertube\nw3m\nirssi\nlocalsend"| dmenu -i +vi -c -l 7 -p "Choose your service:")

case "$config" in
    "nmtui") alacritty -e nmtui;;
    "gophertube") alacritty -e gophertube;;
    "w3m") alacritty -e w3m www.duckduckgo.com;;
    "irssi") alacritty -e irssi;;
    "localsend") alacritty -e flatpak run org.localsend.localsend_app;;

esac
