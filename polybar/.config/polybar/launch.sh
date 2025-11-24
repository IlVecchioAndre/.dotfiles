#!/usr/bin/env bash
# uccidi polybar se già in esecuzione
killall -q polybar

# attendi finché non è completamente chiuso
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# lancia la bar
polybar mybar &

