# Exercices complémentaires - Scripts Bash

## Exercice 6 : Gestionnaire de services

### Objectif
Créer un script qui affiche l'état de plusieurs services système et permet de les démarrer/arrêter.

### Consignes
- Le script doit vérifier l'état d'au moins 3 services (ssh, cron, apache2/nginx)
- Afficher pour chaque service : nom, état (actif/inactif), et s'il est activé au démarrage
- Proposer un menu pour démarrer ou arrêter un service
- Gérer les permissions (sudo) correctement
- Afficher des messages de confirmation après chaque action

### Correction
Voir `corrections/ex06_services.sh`.

---

## Exercice 7 : Nettoyeur de logs

### Objectif
Écrire un script qui nettoie les fichiers de logs anciens d'un système.

### Consignes
- Le script prend en argument le nombre de jours (ex: supprimer les logs de plus de 7 jours)
- Chercher dans `/var/log` les fichiers `.log` et `.gz` correspondants
- Afficher la liste des fichiers qui seront supprimés avec leur taille
- Demander confirmation avant la suppression
- Afficher l'espace disque libéré à la fin
- Écrire un fichier de log de l'opération

### Correction
Voir `corrections/ex07_log_cleaner.sh`.

---

## Exercice 8 : Analyseur d'espace disque

### Objectif
Créer un script qui analyse l'utilisation de l'espace disque et identifie les gros consommateurs.

### Consignes
- Afficher l'utilisation de chaque partition montée
- Identifier les 10 plus gros dossiers dans `/home`
- Afficher la taille de chaque dossier de manière lisible (Mo, Go)
- Colorier en rouge les partitions utilisées à plus de 80%
- Proposer d'exporter le rapport dans un fichier texte

### Correction
Voir `corrections/ex08_disk_analyzer.sh`.

---

## Exercice 9 : Vérificateur de connexion réseau

### Objectif
Écrire un script qui teste la connectivité réseau vers plusieurs serveurs.

### Consignes
- Tester la connexion vers au moins 5 serveurs (ex: google.com, github.com, cloudflare.com, etc.)
- Utiliser `ping` pour vérifier la disponibilité
- Afficher un indicateur de qualité de réponse pour chaque serveur
- Identifier les serveurs inaccessibles
- Afficher un résumé : X/5 serveurs accessibles
- Écrire les résultats dans un fichier

### Correction
Voir `corrections/ex09_network_checker.sh`.

---

## Exercice 10 : Installateur de paquets

### Objectif
Créer un script qui automatise l'installation d'un ensemble de paquets.

### Consignes
- Le script lit une liste de paquets depuis un fichier texte
- Vérifier pour chaque paquet s'il est déjà installé
- Si non installé, proposer de l'installer
- Afficher une barre de progression ou un compteur (X/N paquets installés)
- Gérer les erreurs d'installation
- Créer un rapport final listant les paquets installés avec succès et ceux en erreur

### Script de correction (exemple commenté)
```bash
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
```

---

## Exercice 11 : Générateur de rapports système

### Objectif
Développer un script qui génère un rapport HTML complet sur l'état du système.

### Consignes
Le rapport HTML doit contenir :
- Nom de la machine et version du système
- Utilisation CPU et mémoire
- Espace disque
- Services en cours d'exécution
- Dernières connexions utilisateurs
- Mise en page HTML avec CSS basique
- Ouvrir automatiquement le rapport dans le navigateur à la fin

### Script de correction (exemple commenté)
```bash
#!/bin/bash
# Genere un rapport HTML simple sur l'etat du systeme.

set -euo pipefail

report="./system_report.html"

hostname="$(hostname)"
os_info="$(uname -sr)"

cpu_info() {
  # Extrait un resume CPU si possible.
  if command -v lscpu >/dev/null 2>&1; then
    lscpu | awk -F: '/Model name/ {print $2}' | xargs
  else
    echo "N/A"
  fi
}

mem_info() {
  # Utilise free si disponible.
  if command -v free >/dev/null 2>&1; then
    free -h | awk 'NR==2 {print $3 " / " $2}'
  else
    echo "N/A"
  fi
}

disk_info="$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')"
services_info="$(systemctl list-units --type=service --state=running 2>/dev/null | head -n 10)"
last_users="$(last -n 5 2>/dev/null || echo "N/A")"

cat > "$report" <<HTML
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Rapport systeme</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    h1 { color: #333; }
    pre { background: #f4f4f4; padding: 12px; }
  </style>
</head>
<body>
  <h1>Rapport systeme</h1>
  <h2>Machine</h2>
  <p><strong>Nom:</strong> $hostname</p>
  <p><strong>OS:</strong> $os_info</p>

  <h2>Ressources</h2>
  <p><strong>CPU:</strong> $(cpu_info)</p>
  <p><strong>Memoire:</strong> $(mem_info)</p>
  <p><strong>Disque:</strong> $disk_info</p>

  <h2>Services en cours (extrait)</h2>
  <pre>$services_info</pre>

  <h2>Dernieres connexions</h2>
  <pre>$last_users</pre>
</body>
</html>
HTML

echo "Rapport genere: $report"

# Ouvre le rapport si possible.
if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$report" >/dev/null 2>&1 || true
elif command -v open >/dev/null 2>&1; then
  open "$report" >/dev/null 2>&1 || true
fi
```

---

## Exercice 12 : Synchronisateur de fichiers

### Objectif
Créer un script qui synchronise deux répertoires.

### Consignes
- Prendre en arguments : répertoire source et répertoire destination
- Comparer les fichiers des deux répertoires
- Copier uniquement les fichiers nouveaux ou modifiés
- Afficher la liste des fichiers copiés
- Afficher les statistiques : nombre de fichiers copiés, taille totale
- Gérer les erreurs (permissions, espace disque)
- Option bonus : supprimer dans la destination les fichiers qui n'existent plus dans la source

### Script de correction (exemple commenté)
```bash
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
```

---


## Conseils généraux

### Pour tous les exercices

- Commencez toujours par le shebang `#!/bin/bash`
- Ajoutez des commentaires pour expliquer votre code
- Validez les arguments et les entrées utilisateur
- Gérez les erreurs avec des messages clairs
- Testez vos scripts dans un environnement de test

### Commandes utiles

- `du -sh` : taille d'un dossier
- `df -h` : espace disque
- `systemctl status` : état d'un service
- `find` : rechercher des fichiers
- `ping -c 3` : tester une connexion (3 paquets)
- `wc -l` : compter les lignes

### Gestion des couleurs

```bash
# Définir des couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Utilisation
echo -e "${GREEN}Succès !${NC}"
echo -e "${RED}Erreur !${NC}"
```

---

## Ressources

- **Guide Bash** : https://fr.wikibooks.org/wiki/Programmation_Bash
- **Conditions** : https://buzut.net/maitriser-les-conditions-en-bash/
- **Explainshell** : https://explainshell.com/ (pour comprendre les commandes)
- **ShellCheck** : https://www.shellcheck.net/ (vérifier la qualité du code)
