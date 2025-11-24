#!/bin/bash
brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((brightness * 100 / max))
echo "$percent%"
