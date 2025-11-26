

## Choix du plan global

On va partir sur la plage **10.0.0.0/8** pour garder une grande marge d’évolution.
 On découpe ensuite par **sites**, puis par **sous-réseaux fonctionnels** :

| Site / Service    | Sous-réseau proposé | Taille   | CIDR | Nb. max hôtes | Passerelle (routeur) |
| ----------------- | ------------------- | -------- | ---- | ------------- | -------------------- |
| **Bordeaux**      | LAN                 | 10.1.0.0 | /23  | 510           | 10.1.0.1             |
|                   | DMZ                 | 10.1.2.0 | /28  | 14            | 10.1.2.1             |
|                   | WiFi public         | 10.1.3.0 | /24  | 254           | 10.1.3.1             |
| **Roubaix**       | LAN                 | 10.2.0.0 | /24  | 254           | 10.2.0.1             |
|                   | WiFi public         | 10.2.1.0 | /24  | 254           | 10.2.1.1             |
| **VPN (nomades)** | VPN                 | 10.3.0.0 | /23  | 510           | 10.3.0.1             |

### 💡 Détails & justification

#### **Bordeaux LAN — 10.1.0.0/23**

- Couvre 512 adresses (510 utilisables).
- Actuellement ~45 personnes + serveurs + imprimantes + R&D (12 pers) = 60 postes environ.
- Forte croissance prévue → /23 permet d’aller jusqu’à 510.
- Passerelle du LAN : **10.1.0.1**

#### **DMZ — 10.1.2.0/28**

- 4 serveurs prévus + marge (14 hôtes possibles).
- Parfait pour un sous-réseau isolé et facile à filtrer.
- Passerelle : **10.1.2.1**

#### **WiFi public Bordeaux — 10.1.3.0/24**

- Réservé aux visiteurs, isolé du LAN.
- /24 (254 hôtes) = bonne marge.
- Passerelle : **10.1.3.1**

#### **Roubaix LAN — 10.2.0.0/24**

- ~20 postes max actuellement (11 R&D, 6 commerciaux, 1 IT + copieur).
- /24 permet de gérer l’avenir.
- Passerelle : **10.2.0.1**

#### **WiFi public Roubaix — 10.2.1.0/24**

- Réservé aux visiteurs.
- Passerelle : **10.2.1.1**

#### **VPN — 10.3.0.0/23**

- Pour le télétravail et commerciaux nomades.
- Jusqu’à 510 connexions simultanées possibles.
- Routeur VPN = **10.3.0.1**

## 🖥️ Étape 2 — Câblage logique (préparation Packet Tracer)

### 🔹 Bordeaux

- **Routeur 2901 (Bordeaux)**
  - Interface G0/0 → vers LAN (Switch 3650-24PS n°1)
  - Interface G0/1 → vers DMZ (Switch 3650-24PS n°3)
  - Interface S0/0/0 → vers Routeur VPN (liaison série)
  - Interface G0/2 (SFP) → vers Roubaix (fibre optique)
- **Switchs :**
  - **LAN :** 2×3650 interconnectés (uplink fibre entre eux).
  - **DMZ :** 1×3650 connecté au routeur 2901 (port fibre).
  - **WiFi public :** 1×2960 relié au routeur 2901 (port cuivre).
  - **VPN :** 1×2960 relié au routeur 1941 (port cuivre).
- **Serveurs DMZ :**
  - Web (10.1.2.2)
  - Mail (10.1.2.3)
  - DNS (10.1.2.4)
  - Fichier (10.1.2.5)
- **Fibre optique :**
  - Salle serveur ↔ Bâtiment R&D via module SFP.

### 🔹 Roubaix

- **Routeur 2901 (Roubaix)**
  - Interface G0/0 → LAN (Switch 3650-24PS)
  - Interface G0/1 → WiFi public (Switch 2960)
  - Interface G0/2 (SFP) → lien fibre vers Bordeaux (interconnexion des sites)

------

### 🔹 VPN (Routeur Cisco 1941)

- **Interface S0/0/0** → liaison série avec Bordeaux (2901)
- **Interface G0/0** → sous-réseau VPN (Switch 2960)

## 🧠 **2️⃣ Attribution des IP fixes VLAN 1 des switchs**

> VLAN 1 sert ici à la gestion (SSH, Telnet, SNMP, etc.)
>  On les place **dans le même sous-réseau que le LAN** de chaque site.

### 🏢 **Bordeaux**

| Équipement          | Rôle                  | Sous-réseau | IP VLAN 1     | Remarques                       |
| ------------------- | --------------------- | ----------- | ------------- | ------------------------------- |
| SW1-BDX-LAN1 (3650) | Switch principal LAN  | 10.1.0.0/23 | **10.1.0.10** | Connecté au routeur 2901 (G0/0) |
| SW2-BDX-LAN2 (3650) | Switch secondaire LAN | 10.1.0.0/23 | **10.1.0.11** | Uplink fibre vers SW1           |
| SW3-BDX-DMZ (3650)  | Switch DMZ            | 10.1.2.0/28 | **10.1.2.10** | Connecté au routeur 2901 (G0/1) |
| SW4-BDX-WIFI (2960) | Switch WiFi public    | 10.1.3.0/24 | **10.1.3.10** | Connecté au routeur 2901 (G0/2) |

> Tous reliés en **fibre optique SFP** (GLC-LH-SMD).

### 🏭 **Roubaix**

| Équipement          | Rôle                 | Sous-réseau | IP VLAN 1     | Remarques                       |
| ------------------- | -------------------- | ----------- | ------------- | ------------------------------- |
| SW1-RBX-LAN (3650)  | Switch principal LAN | 10.2.0.0/24 | **10.2.0.10** | Connecté au routeur 2901 (G0/0) |
| SW2-RBX-WIFI (2960) | Switch WiFi public   | 10.2.1.0/24 | **10.2.1.10** | Connecté au routeur 2901 (G0/1) |

------

### 🌐 **VPN (Cisco 1941)**

| Équipement    | Rôle            | Sous-réseau | IP VLAN 1     | Remarques                    |
| ------------- | --------------- | ----------- | ------------- | ---------------------------- |
| SW-VPN (2960) | Switch pour VPN | 10.3.0.0/23 | **10.3.0.10** | Relié au Routeur 1941 (G0/0) |

## 🧩 **3️⃣ Adressage des interfaces principales (Routeurs)**

| Routeur            | Interface                          | Sous-réseau  | Adresse IP   |
| ------------------ | ---------------------------------- | ------------ | ------------ |
| **R2901-Bordeaux** | G0/0 (LAN)                         | 10.1.0.0/23  | **10.1.0.1** |
|                    | G0/1 (DMZ)                         | 10.1.2.0/28  | **10.1.2.1** |
|                    | G0/2 (WiFi)                        | 10.1.3.0/24  | **10.1.3.1** |
|                    | S0/0/0 (VPN lien série vers R1941) | 10.3.1.1/30  | —            |
|                    | G0/3 (vers Roubaix en fibre)       | 10.10.0.1/30 | —            |

| **R2901-Roubaix** | G0/0 (LAN) | 10.2.0.0/24 | **10.2.0.1** |
 | | G0/1 (WiFi) | 10.2.1.0/24 | **10.2.1.1** |
 | | G0/2 (fibre vers Bordeaux) | 10.10.0.2/30 | — |

| **R1941-VPN** | G0/0 (LAN VPN) | 10.3.0.0/23 | **10.3.0.1** |
 | | S0/0/0 (vers Bordeaux série) | 10.3.1.2/30 | — |

## 🖋️ **6️⃣ Exemple de configuration VLAN1 sur un switch (Bordeaux LAN1)**

```
Switch> enable
Switch# configure terminal
Switch(config)# interface vlan 1
Switch(config-if)# ip address 10.1.0.10 255.255.254.0
Switch(config-if)# no shutdown
Switch(config-if)# exit
Switch(config)# ip default-gateway 10.1.0.1
Switch(config)# end
Switch# write
```

enable
configure terminal
hostname R2901-BDX

! ---- Interfaces ----
interface GigabitEthernet0/0
 description LAN_Bordeaux
 ip address 10.1.0.1 255.255.254.0
 no shutdown

interface GigabitEthernet0/1
 description DMZ_Bordeaux
 ip address 10.1.2.1 255.255.255.240
 no shutdown

interface GigabitEthernet0/2
 description WIFI_Public_Bordeaux
 ip address 10.1.3.1 255.255.255.0
 no shutdown

interface GigabitEthernet0/3
 description Lien_Fibre_Roubaix
 ip address 10.10.0.1 255.255.255.252
 no shutdown

interface Serial0/0/0
 description Lien_Serie_VPN
 ip address 10.3.1.1 255.255.255.252
 clock rate 64000
 no shutdown

! ---- Routage statique ----
ip route 10.2.0.0 255.255.254.0 10.10.0.2
ip route 10.3.0.0 255.255.254.0 10.3.1.2

! ---- (Optionnel) Routage dynamique OSPF ----
router ospf 1
 network 10.1.0.0 0.0.1.255 area 0
 network 10.1.2.0 0.0.0.15 area 0
 network 10.1.3.0 0.0.0.255 area 0
 network 10.10.0.0 0.0.0.3 area 0
 network 10.3.1.0 0.0.0.3 area 0

end
write memory

## 🏭 **2️⃣ Routeur Roubaix (R2901-RBX)**

### 🔹 Interfaces

| Interface | Rôle                | Adresse IP | Masque          |
| --------- | ------------------- | ---------- | --------------- |
| G0/0      | LAN Roubaix         | 10.2.0.1   | 255.255.255.0   |
| G0/1      | WiFi public Roubaix | 10.2.1.1   | 255.255.255.0   |
| G0/2      | Fibre vers Bordeaux | 10.10.0.2  | 255.255.255.252 |

enable
configure terminal
hostname R2901-RBX

interface GigabitEthernet0/0
 description LAN_Roubaix
 ip address 10.2.0.1 255.255.255.0
 no shutdown

interface GigabitEthernet0/1
 description WIFI_Public_Roubaix
 ip address 10.2.1.1 255.255.255.0
 no shutdown

interface GigabitEthernet0/2
 description Lien_Fibre_Bordeaux
 ip address 10.10.0.2 255.255.255.252
 no shutdown

! ---- Routage statique ----
ip route 10.1.0.0 255.255.252.0 10.10.0.1
ip route 10.3.0.0 255.255.254.0 10.10.0.1

! ---- (Optionnel) Routage dynamique OSPF ----
router ospf 1
 network 10.2.0.0 0.0.0.255 area 0
 network 10.2.1.0 0.0.0.255 area 0
 network 10.10.0.0 0.0.0.3 area 0

end
write memory

## 🌐 **3️⃣ Routeur VPN (R1941-VPN)**

### 🔹 Interfaces

| Interface | Rôle                     | Adresse IP | Masque          |
| --------- | ------------------------ | ---------- | --------------- |
| G0/0      | LAN VPN                  | 10.3.0.1   | 255.255.254.0   |
| S0/0/0    | Lien série vers Bordeaux | 10.3.1.2   | 255.255.255.252 |

enable
configure terminal
hostname R1941-VPN

interface GigabitEthernet0/0
 description LAN_VPN
 ip address 10.3.0.1 255.255.254.0
 no shutdown

interface Serial0/0/0
 description Lien_Serie_Bordeaux
 ip address 10.3.1.2 255.255.255.252
 no shutdown

! ---- Routage statique ----
ip route 10.1.0.0 255.255.252.0 10.3.1.1
ip route 10.2.0.0 255.255.254.0 10.3.1.1

! ---- (Optionnel) Routage dynamique OSPF ----
router ospf 1
 network 10.3.0.0 0.0.1.255 area 0
 network 10.3.1.0 0.0.0.3 area 0

end
write memory

## 🔁 **Test de connectivité à faire dans Packet Tracer**

| Test                    | Commande                         |
| ----------------------- | -------------------------------- |
| Ping Bordeaux ↔ Roubaix | `ping 10.2.0.1` depuis R2901-BDX |
| Ping VPN ↔ Bordeaux     | `ping 10.3.1.2`                  |
| Ping Bordeaux ↔ VPN LAN | `ping 10.3.0.1`                  |
| Ping Roubaix ↔ VPN LAN  | `ping 10.3.0.1`                  |