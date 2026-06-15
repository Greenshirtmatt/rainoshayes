#!/usr/bin/env bash
#
# build-gallery.sh — one-time/regenerable image pipeline for the Gallery page.
#
# Reads originals from photos/, dedupes by content hash, auto-orients (bakes EXIF
# rotation), and writes two web-optimized WebP renditions per unique photo into
# deploy/images/gallery/{thumb,large}/. Also writes a markup snippet of <figure>
# entries (with intrinsic dimensions, to prevent layout shift) to
# scripts/gallery-figures.html for pasting into deploy/gallery.html.
#
# Requires: ffmpeg (auto-orient + scale), cwebp (encode), sips (dimension read).
# This ffmpeg build lacks the webp encoder, so ffmpeg pipes PNG to cwebp.
#
set -euo pipefail

cd "$(dirname "$0")/.."

SRC_DIR="photos"
OUT_DIR="deploy/images/gallery"
THUMB_DIR="$OUT_DIR/thumb"
LARGE_DIR="$OUT_DIR/large"
SNIPPET="scripts/gallery-figures.html"

THUMB_EDGE=800   # long-edge px for grid thumbnails
LARGE_EDGE=1600  # long-edge px for lightbox images
THUMB_Q=78
LARGE_Q=82

rm -rf "$THUMB_DIR" "$LARGE_DIR"
mkdir -p "$THUMB_DIR" "$LARGE_DIR"
: > "$SNIPPET"

# ffmpeg scale filter: fit within EDGExEDGE (long edge), preserve aspect, never
# upscale, keep even dimensions. autorotate is on by default in ffmpeg.
scale_filter() {
  local edge="$1"
  echo "scale=w='if(gt(iw,ih),min($edge,iw),-2)':h='if(gt(iw,ih),-2,min($edge,ih))'"
}

# Encode one rendition: ffmpeg autorotate+scale -> PNG on stdout -> cwebp.
encode() {
  local src="$1" edge="$2" q="$3" out="$4"
  ffmpeg -y -loglevel error -i "$src" -vf "$(scale_filter "$edge")" \
    -f image2pipe -vcodec png - | cwebp -quiet -q "$q" -o "$out" -- -
}

declare -A seen
i=0

# Collect originals: *.JPG plus the extension-less IMG_5943, sorted for stable order.
while IFS= read -r f; do
  [ -e "$f" ] || continue
  h=$(md5 -q "$f")
  if [ -n "${seen[$h]:-}" ]; then
    echo "skip dup: $f"
    continue
  fi
  seen[$h]=1
  i=$((i+1))
  n=$(printf "%02d" "$i")

  encode "$f" "$THUMB_EDGE" "$THUMB_Q" "$THUMB_DIR/g$n.webp"
  encode "$f" "$LARGE_EDGE" "$LARGE_Q" "$LARGE_DIR/g$n.webp"

  # Read produced thumb dimensions for width/height attrs.
  w=$(sips -g pixelWidth  "$THUMB_DIR/g$n.webp" 2>/dev/null | awk '/pixelWidth/{print $2}')
  hgt=$(sips -g pixelHeight "$THUMB_DIR/g$n.webp" 2>/dev/null | awk '/pixelHeight/{print $2}')

  {
    echo "                    <figure class=\"shot reveal\">"
    echo "                        <a href=\"images/gallery/large/g$n.webp\" class=\"shot-link\">"
    echo "                            <img"
    echo "                                src=\"images/gallery/thumb/g$n.webp\""
    echo "                                width=\"$w\" height=\"$hgt\""
    echo "                                loading=\"lazy\" decoding=\"async\""
    echo "                                alt=\"Rainos Hayes surf coaching\" />"
    echo "                        </a>"
    echo "                    </figure>"
  } >> "$SNIPPET"

  echo "ok  g$n  ${w}x${hgt}  <- $f"
done < <(ls -1 "$SRC_DIR"/*.JPG "$SRC_DIR"/IMG_5943 2>/dev/null | sort)

echo
echo "Generated $i unique photos."
echo "Thumb payload: $(du -sh "$THUMB_DIR" | awk '{print $1}')   Large payload: $(du -sh "$LARGE_DIR" | awk '{print $1}')"
echo "Markup snippet: $SNIPPET"
