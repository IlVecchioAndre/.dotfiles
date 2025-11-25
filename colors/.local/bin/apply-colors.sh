#!/bin/bash

# Load the palette
source ~/.config/colors/palette.sh

xsetroot -solid $DESKTOPBG

# Directory
COLORS_DIR="$HOME/.config/colors"
TEMPLATE_DIR="$COLORS_DIR/templates"

echo "🎨 Applying colors..."

# sub. variables
generate_config() {
    local template=$1
    local output=$2

    # Create directory if doesn't exists
    mkdir -p "$(dirname "$output")"

    # Usa envsubst per sostituire le variabili
    envsubst < "$template" > "$output"
    echo "Created: $output"
}


hex_to_rgba() {
    local hex=$1
    local alpha=${2:-1.0}  # default opaque

    hex=${hex#\#}

    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))

    echo "rgba($r,$g,$b,$alpha)"
}
# export RGBA Zathura
export BGSELECT_RGBA=$(hex_to_rgba "$BGSELECT" 0.5)
export COLOR0_RGBA=$(hex_to_rgba "$COLOR0" 0.5)
export DESKTOPBG_RGBA=$(hex_to_rgba "$DESKTOPBG" 0.4)

# ========== ALACRITTY ==========
echo "Making Alacritty config..."
ALACRITTY_MAIN="$HOME/.config/alacritty/alacritty.toml"
ALACRITTY_COLORS=$(envsubst < "$TEMPLATE_DIR/alacritty.toml.template")

sed -i '/^\[colors\./,/^$/d' "$ALACRITTY_MAIN" 2>/dev/null

echo "" >> "$ALACRITTY_MAIN"
echo "$ALACRITTY_COLORS" >> "$ALACRITTY_MAIN"
echo "✓ Alacritty done"

# ========== POLYBAR ==========
generate_config \
    "$TEMPLATE_DIR/polybar.ini.template" \
    "$HOME/.config/polybar/colors.ini"

# Assicurati che polybar.ini principale includa colors.ini
POLYBAR_MAIN="$HOME/.config/polybar/config.ini"
if [ -f "$POLYBAR_MAIN" ]; then
    if ! grep -q "include-file.*colors.ini" "$POLYBAR_MAIN"; then
        echo "Add this line to the start of $POLYBAR_MAIN:"
        echo "include-file = ~/.config/polybar/colors.ini"
    fi
fi

# ========== I3 ==========
echo "Creating i3 config..."
I3_CONFIG="$HOME/.config/i3/config"
I3_COLORS_FILE="$HOME/.config/i3/colors"

generate_config "$TEMPLATE_DIR/i3-colors.template" "$I3_COLORS_FILE"

# Search for marks
if ! grep -q "# === COLORS START ===" "$I3_CONFIG" 2>/dev/null; then
    echo "ATTENTION: you must manually modify your i3 config:"
    echo "add those lines where you want your color settings to be generated:"
    echo "# === COLORS START ==="
    echo "# === COLORS END ==="
else
    COLORS_CONTENT=$(cat "$I3_COLORS_FILE")

    awk -v colors="$COLORS_CONTENT" '
        /# === COLORS START ===/ {print; print colors; skip=1; next}
        /# === COLORS END ===/ {skip=0}
        !skip
    ' "$I3_CONFIG" > "$I3_CONFIG.tmp"

    mv "$I3_CONFIG.tmp" "$I3_CONFIG"
    echo "✓ i3 done"
fi
#=========== ZATHURA ============
echo "Creating Zathura config..."
generate_config \
    "$TEMPLATE_DIR/colors.zathura.template" \
    "$HOME/.config/zathura/colors-zath"
# Assicurati che zathurarc principale includa colors-zath
ZATHURA_MAIN="$HOME/.config/zathura/zathurarc"
if [ -f "$ZATHURA_MAIN" ]; then
    if ! grep -q "include.*colors-zath" "$ZATHURA_MAIN"; then
        echo "Add this line to your zathura config:"
        echo "include colors-zath"
    fi
fi

# ========== VIM ==========
generate_config \
    "$TEMPLATE_DIR/colors.vim.template" \
    "$HOME/.config/vim/colors-generated.vim"

# ========== RICARICA PROGRAMMI ==========
echo ""
echo "🔄 Reloading config files ..."

if command -v i3-msg &> /dev/null; then
    i3-msg reload > /dev/null 2>&1
    echo "✓ i3 updated"
fi

touch "$ALACRITTY_MAIN"
echo "✓ Alacritty doesn't need reloading"

VIM_RC="$HOME/.vimrc"
if [ -f "$VIM_RC" ] && ! grep -q "colors-generated.vim" "$VIM_RC"; then
    echo "ℹ add this line to your .vimrc:"
    echo "source ~/.config/vim/colors-generated.vim"
fi

echo ""
echo "✨ done"
