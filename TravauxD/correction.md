# 🧩 Réparation du démarrage et restauration système Windows de Mme Michu

## 1️⃣ Démarrage sur le support d’installation
- Démarre depuis une clé USB ou un DVD d’installation Windows.
- Sélectionne **Réparer l’ordinateur** → **Dépannage** → **Invite de commandes**.
> 💡 Tu es alors dans l’environnement de récupération Windows (WinRE), souvent sur le lecteur `X:`.

---

## 2️⃣ Identification des partitions
```bash
diskpart
list volume
exit
```
➡️ Note les lettres de lecteur correspondant à ta partition système (`C:` ou `E:`) et à ton disque principal.  
> 💡Tu peux utiliser le Bloc-notes (`notepad`) pour parcourir les fichiers et confirmer l’emplacement de `Windows`.
> Ou encore utiliser la commande `bcdedit` pour regarder la partition Windows.

---

## 3️⃣ Réparation du secteur de démarrage
Dans l’invite de commandes :
```bash
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
```
Ces commandes réparent :
- `/fixmbr` → le secteur principal d’amorçage (MBR)
- `/fixboot` → le secteur de démarrage Windows
- `/rebuildbcd` → le magasin de configuration de démarrage (BCD)

Si cela échoue, tente :
```bash
bootsect /nt60 SYS
bcdboot E:\Windows /s C: /f BIOS
bcdedit
```
➡️ Cela copie les fichiers essentiels de démarrage sur la partition système et régénère la configuration BCD.

---

## 4️⃣ Vérification et réparation des fichiers système
Depuis l’environnement WinRE :
```bash
sfc /scannow /offbootdir=E:\ /offwindir=E:\Windows /offlogfile=C:\log.txt
```
> 🔎 Ce mode *offline* est utile lorsque Windows ne démarre pas.  Il fait référence au faite que nous ne SOMMES PAS sur le Windows que nous voulons réparer. Nous sommes actuellement sur le CD de Windows, pas sur le Windows de Madame Michu
Le rapport est enregistré dans `C:\log.txt`.

---

## 5️⃣ Vérification et restauration de Winload.exe
- Ouvre le Bloc-notes → explore `E:\Windows\System32`.

---

# ⚙️ Restauration des performances système

## 6️⃣ Analyser les processus
- Ouvre le **Gestionnaire des tâches** (`Ctrl + Shift + Esc`)  
  → Onglet **Processus** : repère ceux qui consomment le plus de CPU ou de RAM.
- Utilise **Process Explorer** (outil SysInternals) pour une analyse plus fine.

---

## 7️⃣ Nettoyer le démarrage
- Ouvre :
  `C:\Users\<NomUtilisateur>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`  
  ou via **Exécuter** → `shell:startup`
- Supprime tout raccourci suspect (`ping.lnk`, `ping.ps1`, etc.)
- Supprime ensuite le fichier malveillant trouvé `C:\Windows\ping.ps1`.
- Vide la corbeille ou fais `Shift + Suppr` pour une suppression définitive.
- Dans le **Gestionnaire des tâches → Démarrage**, désactive **PowerShell** ou toute application inutile.
> 💡 Reboot ! Tant que tu n'as pas redemarré la session ou l'ordinateur, les pannes déjà presentes sont possiblement toujours lancées. pareil pour les virus du coup !

> 💡 Tu peux aussi ouvrir le **Planificateur de tâches** pour repérer des scripts récurrents indésirables.

---

# 💽 Vérification de l’état des disques

## 8️⃣ Vérification via CHKDSK
```bash
chkdsk C: /f /r
chkdsk D: /f /r
```
> `/f` corrige les erreurs, `/r` recherche et répare les secteurs défectueux.

---

## 9️⃣ Vérification graphique
- Clic droit sur le disque → **Propriétés** → **Outils** → **Vérifier**.
- Si un disque est **hors ligne**, fais clic droit → **Mettre en ligne** depuis **Gestion des disques**.

---

# 📂 Récupération des fichiers perdus

## 🔹 Étape 1 : Vérifier la Corbeille
> Restaurer les fichiers supprimés récemment.

## 🔹 Étape 2 : Utiliser l’Historique des fichiers
- **Paramètres** → **Mise à jour et sécurité** → **Sauvegarde**  
  → **Restaurer des fichiers à partir d’une sauvegarde**.
- Tu peux aussi explorer manuellement `E:\FileHistory` pour voir les versions précédentes des fichiers.
- Se tourner vers des solutions de récupération de fichier comme **Recuva** mais hors sujet pour l'atelier.

---

# ✅ Pas mal d'outils !

| Objectif | Commande / Outil |
|-----------|------------------|
| Réparation MBR/Boot | `bootrec`, `bootsect`, `bcdboot` |
| Fichiers système | `sfc`, `dism` (évoqué) |
| Disques | `diskpart`, `chkdsk`, Gestion des disques |
| Démarrage automatique | `shell:startup`, Planificateur de tâches (évoqué) |
| Analyse de performance | Gestionnaire de tâches |
| Restauration de données | Historique des fichiers |
