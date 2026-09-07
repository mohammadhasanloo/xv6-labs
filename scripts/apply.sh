#!/usr/bin/env bash
# Lay one lab's files over a fresh copy of xv6 in build/<lab>.
#
# The labs are kept as the files they changed rather than as a chain of commits,
# so each one starts from the same upstream kernel and can be read on its own.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
lab="${1:-}"

if [ -z "$lab" ] || [ ! -d "$root/labs/$lab" ]; then
    echo "usage: $(basename "$0") <lab>" >&2
    echo "labs:" >&2
    ls "$root/labs" | sed 's/^/  /' >&2
    exit 1
fi

target="$root/build/$lab"
rm -rf "$target"
mkdir -p "$target"
cp -R "$root/xv6/." "$target/"
cp -R "$root/labs/$lab/src/." "$target/"

echo "$lab laid over xv6 in build/$lab"
