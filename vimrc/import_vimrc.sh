#!/bin/bash

set -e

DEST="$HOME/.config/nvim"
FILENAME="init.vim"

cp *.vim "$DEST"

echo "Imported $FILENAME to $DEST."
