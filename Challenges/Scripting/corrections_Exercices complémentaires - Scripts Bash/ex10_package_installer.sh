#!/bin/bash
# Installe une liste de paquets en detectant le gestionnaire disponible.

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <liste_paquets.txt>" >&2
  exit 1
fi

list_file="$1"
report="./install_report.txt"

if [[ ! -f "$list_file" ]]; then
  echo "Erreur: fichier introuvable." >&2
  exit 1
fi

detect_pm() {
  if command -v apt-get >/dev/null 2>&1; then echo "apt";
  elif command -v dnf >/dev/null 2>&1; then echo "dnf";
  elif command -v yum >/dev/null 2>&1; then echo "yum";
  elif command -v pacman >/dev/null 2>&1; then echo "pacman";
  elif command -v brew >/dev/null 2>&1; then echo "brew";
  else echo "none"; fi
}

pm="$(detect_pm)"
if [[ "$pm" == "none" ]]; then
  echo "Aucun gestionnaire de paquets detecte." >&2
  exit 1
fi

is_installed() {
  case "$pm" in
    apt) dpkg -s "$1" >/dev/null 2>&1 ;;
    dnf|yum) rpm -q "$1" >/dev/null 2>&1 ;;
    pacman) pacman -Qi "$1" >/dev/null 2>&1 ;;
    brew) brew list --versions "$1" >/dev/null 2>&1 ;;
  esac
}

install_pkg() {
  case "$pm" in
    apt) sudo apt-get install -y "$1" ;;
    dnf) sudo dnf install -y "$1" ;;
    yum) sudo yum install -y "$1" ;;
    pacman) sudo pacman -S --noconfirm "$1" ;;
    brew) brew install "$1" ;;
  esac
}

total=$(grep -cv '^\s*$' "$list_file")
count=0
> "$report"

while read -r pkg; do
  [[ -z "$pkg" ]] && continue
  count=$((count + 1))
  echo "[$count/$total] $pkg"

  if is_installed "$pkg"; then
    echo "$pkg: deja installe" >> "$report"
    continue
  fi

  read -r -p "Installer $pkg ? (y/n) " ok
  if [[ "$ok" == "y" ]]; then
    if install_pkg "$pkg"; then
      echo "$pkg: installe" >> "$report"
    else
      echo "$pkg: erreur" >> "$report"
    fi
  else
    echo "$pkg: ignore" >> "$report"
  fi
done < "$list_file"

echo "Rapport: $report"
