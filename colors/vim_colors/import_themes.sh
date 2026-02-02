#!/bin/bash

set -e

DEST="$HOME/.config/nvim/colors"

mkdir -p "$DEST"
cp *.vim *.lua "$DEST"

echo "Themes have been copied to $DEST"
