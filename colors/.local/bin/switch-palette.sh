#!/bin/bash

PALETTES_DIR="$HOME/.config/colors/palettes"
CURRENT_PALETTE="$HOME/.config/colors/palette.sh"

if [ ! -d "$PALETTES_DIR" ]; then
    echo "Error: can't find $PALETTES_DIR "
    exit 1
fi

# Seleziona palette
PALETTE=$(ls "$PALETTES_DIR"/*.sh 2>/dev/null | xargs -n1 basename | fzf --prompt="Choose palette: ")

if [ -n "$PALETTE" ]; then
    cp "$PALETTES_DIR/$PALETTE" "$CURRENT_PALETTE"
    echo "Palette $PALETTE Selected"

    # Applica i colori
    if [ -x "$HOME/.local/bin/apply-colors.sh" ]; then
        "$HOME/.local/bin/apply-colors.sh"
    else
        echo "Error: can't find apply-colors.sh or not executable"
    fi
else
    echo "No palette selected"
fi
