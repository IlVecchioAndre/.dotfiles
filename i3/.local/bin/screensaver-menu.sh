#!/bin/sh
# config-menu.sh

config=$(echo -e "bonsai\nmatrix\npipes\nacquario\nastroterm\nclock" | dmenu -i +vi -c -l 7 -p "choose the screensaver:")

case "$config" in
    "bonsai") alacritty -e bash -c "cbonsai -S; echo 'premi per chiudere'; read -n1 -r";;
    "matrix") alacritty -e cmatrix ;;
    "pipes") alacritty -e pipes.sh -t 4;;
    "acquario") alacritty -e asciiquarium ;;
    "astroterm") alacritty -e astroterm ;;
    "clock") alacritty -e tty-clock -c ;;
esac
