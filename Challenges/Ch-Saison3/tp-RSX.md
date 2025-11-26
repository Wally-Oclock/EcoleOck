

| Zone / VLAN           | Rôle                                                        | Sous-réseau       | Passerelle (Routeur BX) | Taille prévue              | Exemple d’adresses       |
| --------------------- | ----------------------------------------------------------- | ----------------- | ----------------------- | -------------------------- | ------------------------ |
| **LAN BX (interne)**  | Postes salariés (services RH, direction, compta, R&D, etc.) | **10.10.0.0 /24** | 10.10.0.1               | ~200 postes                | 10.10.0.10 → 10.10.0.200 |
| **DMZ BX**            | Serveurs (Web, Mail, DNS, FTP)                              | **10.10.1.0 /28** | 10.10.1.1               | 4 serveurs + 2 spare       | 10.10.1.2 → 10.10.1.6    |
| **WiFi Public BX**    | Visiteurs (accès Internet uniquement)                       | **10.10.2.0 /24** | 10.10.2.1               | ~50 clients                | 10.10.2.10 → 10.10.2.50  |
| **VPN (télétravail)** | Salariés nomades connectés au VPN                           | **10.10.3.0 /24** | 10.10.3.1               | ~50 connexions simultanées | 10.10.3.10 → 10.10.3.60  |

| Service                   | Nombre actuel | IPs réservées (à documenter) |
| ------------------------- | ------------- | ---------------------------- |
| Direction                 | 4             | 10.10.0.10–10.10.0.19        |
| Comptabilité              | 10            | 10.10.0.20–10.10.0.29        |
| RH                        | 5             | 10.10.0.30–10.10.0.39        |
| Juridique / Communication | 10            | 10.10.0.40–10.10.0.49        |
| Recherche & Développement | 50            | 10.10.0.50–10.10.0.99        |
| Informatique              | 5             | 10.10.0.100–10.10.0.109      |
| Réserve future            | ~120          | 10.10.0.110–10.10.0.230      |

| Serveur | Rôle                   | Adresse IP | Passerelle |
| ------- | ---------------------- | ---------- | ---------- |
| SRV1    | Serveur Web            | 10.10.1.2  | 10.10.1.1  |
| SRV2    | Serveur Mail           | 10.10.1.3  | 10.10.1.1  |
| SRV3    | Serveur DNS interne    | 10.10.1.4  | 10.10.1.1  |
| SRV4    | Serveur Fichiers / FTP | 10.10.1.5  | 10.10.1.1  |

| Type d’utilisateur  | Description                                | Sous-réseau   | Exemple IPs              |
| ------------------- | ------------------------------------------ | ------------- | ------------------------ |
| Visiteurs / Clients | Accès Internet uniquement, pas d’accès LAN | 10.10.2.0 /24 | 10.10.2.10 → 10.10.2.100 |
| Passerelle          | Interface routeur BX (WiFi public)         | 10.10.2.1     | —                        |

| Élément                            | Description    | Adresse IP            |
| ---------------------------------- | -------------- | --------------------- |
| Routeur BX (interface VPN)         | Passerelle VPN | 10.10.3.1             |
| Utilisateurs distants (PC nomades) | VPN Clients    | 10.10.3.10–10.10.3.60 |