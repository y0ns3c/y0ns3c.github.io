#!/usr/bin/env bash

SRC=src
OUT=docs
PAGES=${SRC}/pages
TEMPLATE=${SRC}/assets/template.html
PAGE_MAKER=./make_page.py

build() {
    mkdir -p "$(dirname $1)"
    cp -rT "$1" "${1/$SRC/$OUT}"
}

mkdir -p "$OUT"

# Basic copy paste
build "${SRC}/.nojekyll"
for f in "${SRC}"/*; do
    if [[ "$f" != "$PAGES" ]]; then
        build "$f"
    fi
done

# Remove template from build output
rm "${TEMPLATE/$SRC/$OUT}"

# Build pages
for page in "$PAGES"/*; do
    if [[ -f "$page" ]]; then
        echo "Building page: $page"
        "$PAGE_MAKER" "$TEMPLATE" "$page" "${page/$PAGES/$OUT}"
    fi
done
