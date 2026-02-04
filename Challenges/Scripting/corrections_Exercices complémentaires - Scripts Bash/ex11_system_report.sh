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
