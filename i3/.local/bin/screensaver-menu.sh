#!/bin/sh
# config-menu.sh

config=$(echo -e "bonsai\nmatrix\npipes\nacquario\nastroterm\nclock" | dmenu -i +vi -c -l 7 -p "choose the screensaver:")

case "$config" in
    "bonsai") alacritty --config-file .config/alacritty/alacritty-dark.toml -e bash -c "cbonsai -S; echo 'press any key to close'; read -n1 -r";;
    "matrix") alacritty -e cmatrix ;;
    "pipes") alacritty --config-file .config/alacritty/alacritty-dark.toml -e pipes.sh -t 4;;
    "acquario") alacritty -e asciiquarium ;;
    "astroterm") alacritty -e astroterm ;;
    "clock") alacritty -e tty-clock -c ;;
esac
