# 📘 LIVRABLE

## WBS – Modernisation de l’infrastructure IT

**Campus de formation professionnelle (500 utilisateurs)**

------

## 1️⃣ Présentation générale du projet

### 1.1 Contexte

Le campus de formation professionnelle accueille environ **500 utilisateurs permanents** (salariés, formateurs et apprenants).
 L’infrastructure IT actuelle ne permet plus de répondre correctement aux besoins en matière de :

- performances
- sécurité
- segmentation réseau
- services numériques modernes

La direction a donc validé un projet de **modernisation complète de l’infrastructure informatique on-premise**, incluant :

- serveurs
- stockage NAS
- firewall
- réseau filaire et Wi-Fi sécurisé

Le projet est piloté par le **Responsable IT**, avec l’appui opérationnel d’un **alternant Administrateur Systèmes & Réseaux**.

------

## 2️⃣ WBS – Work Breakdown Structure

------

## 🟦 LOT 1 – Serveurs

### 1.1 Analyse et conception

- 1.1.1 Analyse des besoins métiers (administration, pédagogie, apprenants)
- 1.1.2 Identification des services à héberger
  - Serveur de fichiers
  - Annuaire (Active Directory / LDAP)
  - Services applicatifs internes
- 1.1.3 Définition de l’architecture serveur (virtualisation, redondance)

### 1.2 Choix et préparation

- 1.2.1 Sélection du matériel serveur
- 1.2.2 Choix du système d’exploitation
- 1.2.3 Préparation du plan d’adressage et d’intégration réseau

### 1.3 Installation et configuration

- 1.3.1 Installation physique (rack, alimentation, câblage)
- 1.3.2 Installation de l’OS serveur
- 1.3.3 Configuration des services systèmes
- 1.3.4 Sécurisation de base (comptes, mises à jour, pare-feu local)

### 1.4 Tests et mise en production

- 1.4.1 Tests de performance
- 1.4.2 Tests d’accès utilisateurs
- 1.4.3 Validation technique
- 1.4.4 Mise en production progressive

## 🟦 LOT 2 – NAS / Stockage

### 2.1 Analyse des besoins

- 2.1.1 Évaluation des volumes de données
- 2.1.2 Définition des profils d’accès
- 2.1.3 Définition de la politique de sauvegarde

### 2.2 Choix et acquisition

- 2.2.1 Sélection de la solution NAS
- 2.2.2 Choix de la configuration RAID
- 2.2.3 Préparation de l’intégration au SI

### 2.3 Installation et configuration

- 2.3.1 Installation physique du NAS
- 2.3.2 Configuration du stockage
- 2.3.3 Création des partages réseau
- 2.3.4 Mise en place des sauvegardes automatiques

### 2.4 Tests et mise en production

- 2.4.1 Tests de charge
- 2.4.2 Tests de restauration
- 2.4.3 Validation et mise en service

------

## 🟦 LOT 3 – Firewall & Sécurité

### 3.1 Analyse et conception

- 3.1.1 Analyse des menaces et risques
- 3.1.2 Définition de la politique de sécurité
- 3.1.3 Définition des flux réseau autorisés

### 3.2 Choix de la solution

- 3.2.1 Sélection du firewall (NGFW)
- 3.2.2 Choix des licences de sécurité
- 3.2.3 Préparation du plan de règles

### 3.3 Installation et configuration

- 3.3.1 Installation du firewall
- 3.3.2 Configuration des règles de filtrage
- 3.3.3 Mise en place des VPN (administration, formateurs)
- 3.3.4 Configuration des logs et alertes

### 3.4 Tests et mise en production

- 3.4.1 Tests d’accès internes / externes
- 3.4.2 Tests de sécurité basiques
- 3.4.3 Validation et bascule définitive

## 🟦 LOT 4 – Réseau & Wi-Fi

### 4.1 Analyse et conception

- 4.1.1 Audit du réseau existant
- 4.1.2 Définition des VLAN
  - Administration
  - Formateurs
  - Apprenants
  - Invités
- 4.1.3 Étude de couverture Wi-Fi

### 4.2 Choix des équipements

- 4.2.1 Sélection des switches managés
- 4.2.2 Sélection des bornes Wi-Fi
- 4.2.3 Préparation des configurations

### 4.3 Déploiement et configuration

- 4.3.1 Installation des switches
- 4.3.2 Configuration des VLAN
- 4.3.3 Installation des bornes Wi-Fi
- 4.3.4 Configuration SSID et sécurité (WPA2/WPA3, portail captif)

### 4.4 Tests et mise en production

- 4.4.1 Tests de connectivité
- 4.4.2 Tests de débit et roaming
- 4.4.3 Mise en production

## 🟦 LOT 5 – Pilotage, documentation et accompagnement

### 5.1 Gestion de projet

- 5.1.1 Suivi planning et avancement
- 5.1.2 Coordination avec la direction
- 5.1.3 Gestion des risques

### 5.2 Documentation

- 5.2.1 Documentation d’architecture
- 5.2.2 Procédures d’exploitation
- 5.2.3 Plan de sauvegarde et reprise

### 5.3 Formation et transfert de compétences

- 5.3.1 Formation interne
- 5.3.2 Montée en compétences de l’alternant
- 5.3.3 Support post-déploiement

## 3️⃣ RACI – Synthèse

| Activité               | Resp. IT | Alternant | Direction | Prestataire |
| ---------------------- | -------- | --------- | --------- | ----------- |
| Analyse des besoins    | R        | C         | C         |             |
| Architecture technique | R        | C         |           |             |
| Installation serveurs  | R        | A         |           |             |
| Configuration NAS      | R        | A         |           |             |
| Firewall & sécurité    | R        | C         |           | R           |
| VLAN & Wi-Fi           | R        | A         |           |             |
| Validation finale      | R        |           | A         |             |

**R** = Responsable
 **A** = Acteur
 **C** = Consulté
 **I** = Informé

## 4️⃣ Planning prévisionnel – Gantt (macro)

```
Semaines →  S1  S2  S3  S4  S5  S6  S7  S8
Analyse      ███ ███
Serveurs         ███ ███ ███
NAS                  ███ ███
Firewall                 ███ ███
Réseau & Wi-Fi               ███ ███ ███
Tests & MEP                         ███ ███
Documentation                         ███ ███
```

------

## 5️⃣ Conclusion

Ce projet permet :

- une **infrastructure sécurisée et segmentée**
- une **meilleure qualité de service** pour les utilisateurs
- une **montée en compétences progressive de l’alternant**
- une **base évolutive** pour les futurs besoins numériques du campus

Le WBS, le RACI et le planning constituent un **ensemble cohérent de pilotage**, conforme aux attentes d’un **Administrateur Systèmes & Réseaux** en environnement professionnel.