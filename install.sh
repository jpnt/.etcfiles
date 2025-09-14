#!/bin/sh
[ $# -eq 1 ] || { echo "usage: $0 <dir>"; exit 1; }
[ -d "$1" ] || { echo "error: $1 not found or is not a directory"; exit 1; }

src="$1"

find "$src" -type f -printf '%P\n' | while read -r rel_path; do
    target_path="/$rel_path"

    mkdir -p "$(dirname "$target_path")"
    [ -e "$target_path" ] && mv "$target_path" "$target_path.bak"
    cp "$src/$rel_path" "$target_path" && echo "Installed $src/$rel_path -> $target_path"
    # if is something devious...
    # chmod xxx "$target_path"
done
