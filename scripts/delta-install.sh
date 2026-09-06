#!/usr/bin/env bash
set -euo pipefail

tarball="${1:-$HOME/Downloads/delta-linux-x86_64.tar.gz}"
dir="$(mktemp --directory)"
trap 'rm -rf "$dir"' EXIT

tar --extract --gzip --file "$tarball" --directory "$dir"
"$dir/Delta/install.sh" delta-app
