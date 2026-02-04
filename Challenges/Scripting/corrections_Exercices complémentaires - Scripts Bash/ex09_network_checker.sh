#!/bin/bash
# Verifie la connectivite vers une liste de serveurs.

set -euo pipefail

servers=("google.com" "github.com" "cloudflare.com" "openai.com" "wikipedia.org")
report="./network_report.txt"
ok=0

echo "Resultats:"
> "$report"

for host in "${servers[@]}"; do
  # On envoie 3 paquets; si ping echoue, le serveur est considere inaccessible.
  if output=$(ping -c 3 -W 1 "$host" 2>/dev/null); then
    loss=$(echo "$output" | awk -F',' '/packet loss/ {gsub(/%/,"",$3); print $3}' | awk '{print $1}')
    if [[ "$loss" -le 20 ]]; then
      quality="bonne"
    elif [[ "$loss" -le 60 ]]; then
      quality="moyenne"
    else
      quality="faible"
    fi
    echo "- $host : accessible (qualite $quality)"
    echo "$host: accessible (qualite $quality)" >> "$report"
    ok=$((ok + 1))
  else
    echo "- $host : inaccessible"
    echo "$host: inaccessible" >> "$report"
  fi
done

echo "Resume: $ok/${#servers[@]} serveurs accessibles"
echo "Resume: $ok/${#servers[@]} serveurs accessibles" >> "$report"
echo "Rapport: $report"
