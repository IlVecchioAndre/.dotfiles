#!/bin/bash

# Script di notifica batteria per i3wm
# Controlla il livello della batteria e invia notifiche

# Soglie di avviso (modificabili)
SOGLIA_BASSA=20
SOGLIA_CRITICA=10

# File per evitare notifiche ripetute
FLAG_FILE="/tmp/battery_notified"

# Ottieni lo stato della batteria
BATTERY_PATH="/sys/class/power_supply/BAT0"
if [ ! -d "$BATTERY_PATH" ]; then
    BATTERY_PATH="/sys/class/power_supply/BAT1"
fi

if [ ! -d "$BATTERY_PATH" ]; then
    echo "Batteria non trovata"
    exit 1
fi

CAPACITY=$(cat "$BATTERY_PATH/capacity")
STATUS=$(cat "$BATTERY_PATH/status")

# Se la batteria è in carica, rimuovi il flag e esci
if [ "$STATUS" = "Charging" ] || [ "$STATUS" = "Full" ]; then
    rm -f "$FLAG_FILE"
    exit 0
fi

# Controlla il livello e invia notifiche
if [ "$CAPACITY" -le "$SOGLIA_CRITICA" ]; then
    if [ ! -f "$FLAG_FILE" ] || [ "$(cat $FLAG_FILE)" != "critica" ]; then
        notify-send -u critical "BATTERIA CRITICA" "Batteria al ${CAPACITY}%! Collega il caricatore immediatamente!"
        echo "critica" > "$FLAG_FILE"
    fi
elif [ "$CAPACITY" -le "$SOGLIA_BASSA" ]; then
    if [ ! -f "$FLAG_FILE" ] || [ "$(cat $FLAG_FILE)" != "bassa" ]; then
        notify-send -u normal "🔋 Batteria bassa" "Batteria al ${CAPACITY}%. Considera di collegare il caricatore."
        echo "bassa" > "$FLAG_FILE"
    fi
else
    rm -f "$FLAG_FILE"
fi
