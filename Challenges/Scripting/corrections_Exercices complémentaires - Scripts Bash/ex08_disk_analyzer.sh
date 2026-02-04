#!/bin/bash
# Analyse l'occupation disque et met en evidence les partitions chargees.

set -euo pipefail

report_file="./disk_report.txt"

echo "Utilisation des partitions :"
df -hP | awk 'NR==1 {print $0; next} {print $0}' | while read -r line; do
  used_pct=$(echo "$line" | awk '{print $5}' | tr -d '%')
  if [[ "$used_pct" -ge 80 ]]; then
    # Rouge pour les partitions au-dessus du seuil.
    echo -e "\033[0;31m$line\033[0m"
  else
    echo "$line"
  fi
done

echo
echo "Top 10 des dossiers les plus lourds dans /home :"
du -h --max-depth=1 /home 2>/dev/null | sort -hr | head -n 10

echo
read -r -p "Exporter le rapport dans un fichier ? (y/n) " export_choice
if [[ "$export_choice" == "y" ]]; then
  {
    echo "Utilisation des partitions :"
    df -hP
    echo
    echo "Top 10 des dossiers dans /home :"
    du -h --max-depth=1 /home 2>/dev/null | sort -hr | head -n 10
  } > "$report_file"
  echo "Rapport ecrit dans $report_file"
fi
