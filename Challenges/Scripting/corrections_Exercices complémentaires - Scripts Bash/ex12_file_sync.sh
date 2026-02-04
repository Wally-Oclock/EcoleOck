#!/bin/bash
# Synchronise deux repertoires en utilisant rsync.

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <source> <destination> [--delete]" >&2
  exit 1
fi

src="$1"
dst="$2"
delete_flag=""

if [[ "${3:-}" == "--delete" ]]; then
  delete_flag="--delete"
fi

if ! command -v rsync >/dev/null 2>&1; then
  echo "Erreur: rsync est requis." >&2
  exit 1
fi

# --itemize-changes liste les fichiers modifies/copied.
output=$(rsync -av $delete_flag --itemize-changes "$src"/ "$dst"/)
echo "$output"

# Extraction d'un resume simple a partir des stats.
stats=$(rsync -av $delete_flag --stats "$src"/ "$dst"/)
files_copied=$(echo "$stats" | awk -F: '/Number of regular files transferred/ {print $2}' | xargs)
total_size=$(echo "$stats" | awk -F: '/Total transferred file size/ {print $2}' | xargs)

echo "Fichiers copies: ${files_copied:-0}"
echo "Taille totale transferee: ${total_size:-0}"
