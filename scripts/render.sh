#!/usr/bin/env bash
# Renders 3D images of both board variants for the README.
# Usage: ./scripts/render.sh   (run from anywhere)
#
# The images show the fully assembled board: parts marked "do not populate"
# (FRDM headers, OLED socket, SAW filter) are rendered as well. To do this the
# board is copied to a temporary folder and the DNP flag is removed there;
# the design files themselves are not changed.
set -euo pipefail

cd "$(dirname "$0")/.."

KICAD_CLI="${KICAD_CLI:-$(command -v kicad-cli || echo /Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli)}"
OUT="$PWD/documentation/images"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$OUT"

# render <pcb> <output name> [kicad-cli pcb render options...]
render() {
  local pcb=$1 name=$2; shift 2
  echo "Rendering documentation/images/$name.png"
  "$KICAD_CLI" pcb render "$pcb" -o "$OUT/$name.png" \
    --width 1600 --height 800 --background transparent "$@" >/dev/null
}

for variant in "FRDM-SX1255/FRDM-SX1255-V2.kicad_pcb:v2" "FRDM-SX1255+/FRDM-SX1255+ V2.kicad_pcb:v2-plus"; do
  src=${variant%%:*}
  tag=${variant##*:}

  # Temporary copy next to its 3D models (${KIPRJMOD}/3dmodels), without DNP flags
  work="$TMP/$tag"
  mkdir -p "$work"
  cp -R "$(dirname "$src")/3dmodels" "$work/"
  pcb="$work/board.kicad_pcb"
  perl -pe 's/(\(attr [^)]*?) dnp\)/$1)/' "$src" > "$pcb"

  render "$pcb" "pcb-$tag-3d"     --quality high  --side top    --perspective --rotate '-40,0,-30' --zoom 1.15 --pan '-1.6,0.6,0'
  render "$pcb" "pcb-$tag-top"    --quality basic --side top    --zoom 1.3
  render "$pcb" "pcb-$tag-bottom" --quality basic --side bottom --zoom 1.3
done
