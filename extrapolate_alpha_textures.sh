#!/bin/bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

shopt -s globstar
for f in vanilla-rally/src/main/assets/**/*.png; do
    if file "$f" | grep RGBA > /dev/null; then
        echo "Processing $f"
        extrapolate_alpha_texture "$f" "$f" --niterations 12345678 --sigma 3
    fi
done
