#!/usr/bin/env bash
set -u
dir="$1"; cache="$2"; res="$3"
mkdir -p "$cache"
shopt -s nullglob nocaseglob
for f in "$dir"/*.{jpg,jpeg,png,webp,avif,heic,heif}; do
    c="$cache/$(basename "$f").jpg"
    if [ "$c" -nt "$f" ]; then
        printf '%s\n' "$f"
    else
        b=$(basename "$f")
        w=$(printf '%s' "$res" | cut -dx -f1)
        h=$(printf '%s' "$res" | tr -d '^' | cut -dx -f2)
        if ffmpeg -y -loglevel error -i "$f" -vf "scale=${w}:${h}:force_original_aspect_ratio=increase" -frames:v 1 -q:v 2 "$cache/.$b.jpg" 2>/dev/null; then
            mv "$cache/.$b.jpg" "$c"
            printf '%s\n' "$f"
        fi
    fi
done
