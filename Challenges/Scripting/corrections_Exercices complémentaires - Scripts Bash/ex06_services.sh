#!/bin/bash
# Gestionnaire de services simple avec systemd.
# Le script affiche l'etat de services predefinis et propose une action.

set -euo pipefail

services=("ssh" "cron" "apache2")

require_command() {
  # Verifie que systemctl est disponible.
  command -v "$1" >/dev/null 2>&1 || {
    echo "Erreur: commande '$1' introuvable." >&2
    exit 1
  }
}

service_state() {
  # Retourne "actif" ou "inactif" selon l'etat systemd.
  if systemctl is-active --quiet "$1"; then
    echo "actif"
  else
    echo "inactif"
  fi
}

service_enabled() {
  # Retourne "active au demarrage" ou "inactive au demarrage".
  if systemctl is-enabled --quiet "$1"; then
    echo "active au demarrage"
  else
    echo "inactive au demarrage"
  fi
}

show_services() {
  echo "Etat des services :"
  for s in "${services[@]}"; do
    echo "- $s : $(service_state "$s") / $(service_enabled "$s")"
  done
}

require_command systemctl
show_services

echo
echo "Menu:"
echo "1) Demarrer un service"
echo "2) Arreter un service"
echo "3) Quitter"
read -r -p "Votre choix: " choice

case "$choice" in
  1|2)
    read -r -p "Nom du service: " svc
    if [[ ! " ${services[*]} " =~ " ${svc} " ]]; then
      echo "Service non pris en charge." >&2
      exit 1
    fi
    if [[ "$choice" == "1" ]]; then
      sudo systemctl start "$svc"
      echo "Service '$svc' demarre."
    else
      sudo systemctl stop "$svc"
      echo "Service '$svc' arrete."
    fi
    ;;
  3) echo "Fin." ;;
  *) echo "Choix invalide." >&2; exit 1 ;;
esac
