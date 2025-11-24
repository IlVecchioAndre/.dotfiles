#!/bin/bash

PALETTES_DIR="$HOME/.config/colors/palettes"
CURRENT_PALETTE="$HOME/.config/colors/palette.sh"

# Verifica che la directory esista
if [ ! -d "$PALETTES_DIR" ]; then
    echo "Errore: directory $PALETTES_DIR non trovata"
    exit 1
fi

# Seleziona palette
PALETTE=$(ls "$PALETTES_DIR"/*.sh 2>/dev/null | xargs -n1 basename | fzf --prompt="Scegli palette: ")

if [ -n "$PALETTE" ]; then
    cp "$PALETTES_DIR/$PALETTE" "$CURRENT_PALETTE"
    echo "Palette $PALETTE selezionata"

    # Applica i colori
    if [ -x "$HOME/.local/bin/apply-colors.sh" ]; then
        "$HOME/.local/bin/apply-colors.sh"
    else
        echo "Errore: apply-colors.sh non trovato o non eseguibile"
    fi
else
    echo "Nessuna palette selezionata"
fi
