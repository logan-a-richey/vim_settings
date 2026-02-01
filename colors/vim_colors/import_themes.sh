#!/bin/bash

set -e

DEST="$HOME/.config/nvim/colors"

mkdir -p "$DEST"
cp *.vim "$DEST"

echo "Themes have been copied to $DEST"
