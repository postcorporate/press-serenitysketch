#!/usr/bin/env bash
# Build the static site folder for GitHub Pages (or manual copy to the public repo).
# assets/downloads/ (sources + zip) stay in the private repo only; the live ZIP is on R2.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="${1:-$ROOT/site}"

rm -rf "$OUT"
mkdir -p "$OUT"

cp "$ROOT/index.html" "$OUT/"
cp -r "$ROOT/styles" "$OUT/"
cp -r "$ROOT/assets" "$OUT/"

if [[ -d "$OUT/assets/downloads" ]]; then
  rm -rf "$OUT/assets/downloads"
fi

if [[ -f "$ROOT/CNAME" ]]; then
  cp "$ROOT/CNAME" "$OUT/"
fi

if [[ -f "$ROOT/.gitattributes" ]]; then
  cp "$ROOT/.gitattributes" "$OUT/"
fi

touch "$OUT/.nojekyll"

echo "Assembled site at $OUT"
