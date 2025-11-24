#!/bin/bash

# Carica la palette
source ~/.config/colors/palette.sh

xsetroot -solid $DESKTOPBG

# Directory
COLORS_DIR="$HOME/.config/colors"
TEMPLATE_DIR="$COLORS_DIR/templates"

echo "🎨 Applicando palette di colori..."

# Funzione per sostituire variabili nei template
generate_config() {
    local template=$1
    local output=$2

    # Crea la directory se non esiste
    mkdir -p "$(dirname "$output")"

    # Usa envsubst per sostituire le variabili
    envsubst < "$template" > "$output"
    echo "✓ Generato: $output"
}



# Funzione per convertire HEX in RGBA
hex_to_rgba() {
    local hex=$1
    local alpha=${2:-1.0}  # default opaco se non specificato

    # Rimuovi il # se presente
    hex=${hex#\#}

    # Converti in RGB
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))

    echo "rgba($r,$g,$b,$alpha)"
}
# Esporta versioni RGBA dei colori per Zathura
export BGSELECT_RGBA=$(hex_to_rgba "$BGSELECT" 0.5)
export COLOR0_RGBA=$(hex_to_rgba "$COLOR0" 0.5)
export DESKTOPBG_RGBA=$(hex_to_rgba "$DESKTOPBG" 0.4)

# ========== ALACRITTY ==========
echo "Generando configurazione Alacritty..."
ALACRITTY_MAIN="$HOME/.config/alacritty/alacritty.toml"
ALACRITTY_COLORS=$(envsubst < "$TEMPLATE_DIR/alacritty.toml.template")

# Rimuovi eventuali sezioni [colors.*] esistenti
sed -i '/^\[colors\./,/^$/d' "$ALACRITTY_MAIN" 2>/dev/null
# Aggiungi le nuove
echo "" >> "$ALACRITTY_MAIN"
echo "$ALACRITTY_COLORS" >> "$ALACRITTY_MAIN"
echo "✓ Alacritty configurato"

# ========== POLYBAR ==========
generate_config \
    "$TEMPLATE_DIR/polybar.ini.template" \
    "$HOME/.config/polybar/colors.ini"

# Assicurati che polybar.ini principale includa colors.ini
POLYBAR_MAIN="$HOME/.config/polybar/config.ini"
if [ -f "$POLYBAR_MAIN" ]; then
    if ! grep -q "include-file.*colors.ini" "$POLYBAR_MAIN"; then
        echo " Aggiungi questa riga all'inizio di $POLYBAR_MAIN:"
        echo "include-file = ~/.config/polybar/colors.ini"
    fi
fi
# ========== MPV ==========
generate_config \
    "$TEMPLATE_DIR/mpv.template" \
    "$HOME/.config/mpv/scripts/osc.lua"



# ========== I3 ==========
echo "Generando configurazione i3..."
I3_CONFIG="$HOME/.config/i3/config"
I3_COLORS_FILE="$HOME/.config/i3/colors"

# Genera il file colors
generate_config "$TEMPLATE_DIR/i3-colors.template" "$I3_COLORS_FILE"

# Verifica se il config ha già un marcatore per i colori
if ! grep -q "# === COLORS START ===" "$I3_CONFIG" 2>/dev/null; then
    echo " ATTENZIONE: Devi modificare manualmente il config di i3"
    echo "E aggiungi queste righe dove vuoi i colori:"
    echo "# === COLORS START ==="
    echo "# === COLORS END ==="
else
    # Inserisci i colori tra i marcatori
    COLORS_CONTENT=$(cat "$I3_COLORS_FILE")

    # Usa awk per sostituire il contenuto tra i marcatori
    awk -v colors="$COLORS_CONTENT" '
        /# === COLORS START ===/ {print; print colors; skip=1; next}
        /# === COLORS END ===/ {skip=0}
        !skip
    ' "$I3_CONFIG" > "$I3_CONFIG.tmp"

    mv "$I3_CONFIG.tmp" "$I3_CONFIG"
    echo "✓ i3 configurato"
fi
#=========== ZATHURA ============
echo "Generando configurazione Zathura..."
generate_config \
    "$TEMPLATE_DIR/colors.zathura.template" \
    "$HOME/.config/zathura/colors-zath"
# Assicurati che zathurarc principale includa colors-zath
ZATHURA_MAIN="$HOME/.config/zathura/zathurarc"
if [ -f "$ZATHURA_MAIN" ]; then
    if ! grep -q "include.*colors-zath" "$ZATHURA_MAIN"; then
        echo "ℹ️ Aggiungi questa riga al tuo zathurarc:"
        echo "include colors-zath"
    fi
fi

# ========== VIM ==========
generate_config \
    "$TEMPLATE_DIR/colors.vim.template" \
    "$HOME/.config/vim/colors-generated.vim"

# ========== RICARICA PROGRAMMI ==========
echo ""
echo "🔄 Ricaricando configurazioni..."

# Ricarica i3
if command -v i3-msg &> /dev/null; then
    i3-msg reload > /dev/null 2>&1
    echo "✓ i3 ricaricato"
fi

# Tocca il file di config di Alacritty per forzare il reload
touch "$ALACRITTY_MAIN"
echo "✓ Alacritty si aggiornerà automaticamente"

# Per Vim, crea un autocmd se non esiste
VIM_RC="$HOME/.vimrc"
if [ -f "$VIM_RC" ] && ! grep -q "colors-generated.vim" "$VIM_RC"; then
    echo "ℹ Aggiungi questa riga al tuo .vimrc:"
    echo "source ~/.config/vim/colors-generated.vim"
fi

echo ""
echo "✨ Palette applicata con successo!"
