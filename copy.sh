#!/usr/bin/env bash
# copy.sh: copy config templates into the configs/ directory
# Usage: ./copy.sh [template_name ...]
#   If no arguments are given, all templates are copied.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
CONFIGS_DIR="$SCRIPT_DIR/configs"

mkdir -p "$CONFIGS_DIR"

if [[ $# -eq 0 ]]; then
    templates=("$TEMPLATES_DIR"/*)
else
    templates=()
    for name in "$@"; do
        templates+=("$TEMPLATES_DIR/$name")
    done
fi

for src in "${templates[@]}"; do
    name="$(basename "$src")"
    dest="$CONFIGS_DIR/$name"
    if [[ ! -f "$src" ]]; then
        echo "Warning: template '$src' not found, skipping." >&2
        continue
    fi
    cp "$src" "$dest"
    echo "Copied $name -> configs/$name"
done
