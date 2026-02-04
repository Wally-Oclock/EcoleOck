#!/bin/bash
# Nettoyeur de logs avec confirmation et rapport simple.

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <jours>" >&2
  exit 1
fi

days="$1"
if ! [[ "$days" =~ ^[0-9]+$ ]]; then
  echo "Erreur: le nombre de jours doit etre un entier." >&2
  exit 1
fi

log_dir="/var/log"
report="./log_cleanup_report.txt"
tmp_list="$(mktemp)"

# Liste les fichiers candidats avec leur taille lisible.
find "$log_dir" -type f \( -name "*.log" -o -name "*.gz" \) -mtime +"$days" \
  -print0 | while IFS= read -r -d '' f; do
    du -h "$f" >> "$tmp_list"
  done

if [[ ! -s "$tmp_list" ]]; then
  echo "Aucun fichier a supprimer."
  rm -f "$tmp_list"
  exit 0
fi

echo "Fichiers a supprimer :"
cat "$tmp_list"
echo
read -r -p "Confirmer la suppression ? (y/n) " confirm
if [[ "$confirm" != "y" ]]; then
  echo "Annule."
  rm -f "$tmp_list"
  exit 0
fi

# Calcule la taille totale avant suppression (en Ko).
total_kb=$(awk '{sum += $1} END {print sum+0}' < <(du -k $(awk '{print $2}' "$tmp_list")))

# Supprime les fichiers listes.
awk '{print $2}' "$tmp_list" | while read -r f; do
  rm -f "$f"
done

echo "Espace libere: $((total_kb)) Ko"
{
  echo "Suppression effectuee."
  echo "Fichiers supprimes:"
  awk '{print $2}' "$tmp_list"
  echo "Espace libere: $((total_kb)) Ko"
} > "$report"

rm -f "$tmp_list"
echo "Rapport: $report"
