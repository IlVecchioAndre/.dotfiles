#!/bin/bash
# Converte symlink in file reali nella repository dotfiles
# Uso: ./convert-symlinks-to-files.sh

set -e

DOTFILES_DIR="$HOME/.dotfiles"

echo "================================"
echo "CONVERSIONE SYMLINK → FILE REALI"
echo "================================"
echo ""

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Directory $DOTFILES_DIR non trovata!"
    exit 1
fi

cd "$DOTFILES_DIR"

echo "Cerco symlink nella repository..."
echo ""

# Trova tutti i symlink nel repository
symlink_count=0
while IFS= read -r -d '' symlink; do
    # Ottieni il percorso del file originale
    original=$(readlink -f "$symlink")
    
    # Verifica che il file originale esista
    if [ -f "$original" ]; then
        echo "📄 Trovato: $symlink"
        echo "   → Punta a: $original"
        
        # Rimuovi il symlink
        rm "$symlink"
        
        # Copia il file reale al suo posto
        cp "$original" "$symlink"
        
        echo "   ✓ Convertito in file reale"
        echo ""
        
        ((symlink_count++))
    else
        echo "⚠️  Warning: $symlink punta a $original che non esiste"
        echo ""
    fi
done < <(find . -type l -print0)

echo "================================"
echo "✓ Conversione completata!"
echo "================================"
echo ""
echo "File convertiti: $symlink_count"
echo ""
echo "PROSSIMI PASSI:"
echo "1. Verifica i file: ls -la $DOTFILES_DIR"
echo "2. Commit su Git:"
echo "   cd $DOTFILES_DIR"
echo "   git add ."
echo "   git commit -m 'Convert symlinks to real files'"
echo "   git push"
echo ""
echo "3. Esegui ./install.sh per ricreare i symlink nella home"
echo ""
