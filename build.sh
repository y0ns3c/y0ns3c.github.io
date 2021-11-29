#!/usr/bin/env bash

SRC=src
OUT=build
PAGES=${SRC}/pages
TEMPLATE=${SRC}/assets/template.html
PAGE_MAKER=./make_page.py

build() {
    mkdir -p "$(dirname $1)"
    cp -rT "$1" "${1/$SRC/$OUT}"
}


# Basic copy paste
build "${SRC}/.nojekyll"
for f in "${SRC}"/*; do
    if [[ "$f" != "$PAGES" ]]; then
        build "$f"
    fi
done

# Build pages
mkdir -p "${PAGES/$SRC/$OUT}"
for page in "$PAGES"/*; do
    "$PAGE_MAKER" "$TEMPLATE" "$page" "${page/$SRC/$OUT}"
done
