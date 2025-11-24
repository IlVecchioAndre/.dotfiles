#!/bin/bash
# Mostra l'ultimo elemento della clipboard
clip=$(xclip -o -selection clipboard 2>/dev/null | head -n1)
if [ -z "$clip" ]; then
    echo "Empty"
else
    echo "$clip"
fi
