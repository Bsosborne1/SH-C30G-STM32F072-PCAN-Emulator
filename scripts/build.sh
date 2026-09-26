#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
OUT="$ROOT/build"

cd "$ROOT"

if [[ ! -f "$UPSTREAM/Makefile" ]]; then
  git submodule update --init --recursive
fi

cp "$ROOT/overrides/usbd_desc-fixup.c" "$UPSTREAM/Src/usbd_desc-fixup.c"

make -C "$UPSTREAM" clean
make -C "$UPSTREAM" canable MCU_SERIES=F072

mkdir -p "$OUT"
for ext in hex bin dfu elf; do
  src="$UPSTREAM/build-canable/pcan_canable_hw.$ext"
  if [[ -f "$src" ]]; then
    cp "$src" "$OUT/"
  fi
done

printf '\nBuild complete. Output files:\n'
ls -lh "$OUT"
