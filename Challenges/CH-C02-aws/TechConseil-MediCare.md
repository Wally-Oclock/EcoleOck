## 1. Architecture cible

Nous recommandons une transition vers un modèle **Cloud Hybride**, privilégiant le **SaaS** pour les fonctions transverses et le **PaaS** pour votre application métier afin de décharger votre administrateur des tâches de maintenance matérielle.

|**Composant**|**Proposition**|**Modèle**|**Provider**|**Justification**|
|---|---|---|---|---|
|**Identités**|Azure AD (Entra ID)|SaaS|Microsoft|Standard du marché, gère l'accès sécurisé (MFA) partout.|
|**Messagerie + Bureautique**|Microsoft 365 Business|SaaS|Microsoft|Collaboration temps réel, remplace les serveurs locaux.|
|**Fichiers partagés**|SharePoint / OneDrive|SaaS|Microsoft|Accès distant natif, fin du VPN obligatoire pour les docs.|
|**App métier (PHP)**|App Service|PaaS|Azure|Plus de serveur à gérer, mise à jour simplifiée, scalabilité.|
|**Base de données**|Azure Database (MySQL)|PaaS|Azure|Sauvegardes et patchs automatiques, haute disponibilité.|
|**Sauvegardes**|Azure Backup / Recovery|PaaS|Azure|Automatisation complète, immuabilité contre les ransomwares.|
|**Site web**|Web PaaS|PaaS|OVHcloud|Coût très faible, simple et isolé du réseau interne.|

### Schéma de l'architecture cible

_(Note : Ce schéma illustre la connexion sécurisée des utilisateurs via internet ou VPN vers le hub de services Cloud centralisé)._

---

## 2. Choix du provider : Pourquoi Microsoft Azure ?

|**Critère**|**Azure**|**AWS**|**OVHcloud**|
|---|---|---|---|
|**Localisation France**|Oui (3 zones)|Oui|Oui|
|**Services PaaS**|Très complets|Très complets|En croissance|
|**Coût estimé**|Modéré (Optimisable)|Élevé|Faible|
|**Support / Simplicité**|Excellente (Écosystème Win)|Complexe|Simple mais moins de services|

**Conclusion :** Nous retenons **Azure**. C'est le choix le plus cohérent pour MediCare+ car il s'intègre nativement avec vos environnements Windows existants (Active Directory). Cela minimise la courbe d'apprentissage pour votre administrateur et permet de mutualiser les licences via Microsoft 365.

---

## 3. Estimation budgétaire (Ordre de grandeur)

L'estimation pour 50 utilisateurs s'établit à environ **1 150 € / mois**, soit **~13 800 € / an**.

- **Hypothèses :** * Licences M365 Business Premium (incluant sécurité avancée & MFA).
    
    - Instances Azure "Reserved" (engagement 1 an) pour réduire les coûts de 30%.
        
    - Stockage de données ~1 To avec rétention légale.
        
- **Économie :** Vous réduisez votre budget IT annuel de **~70%** (de 46k€ à ~14k€), tout en supprimant les frais de renouvellement matériel (CAPEX) au profit d'un abonnement prévisible (OPEX).
    

---

## 4. Points d'attention et réduction des risques

1. **Acculturation technique :** L'équipe n'est pas à l'aise avec le Cloud.
    
    - _Réduction :_ Formation de 2 jours pour l'administrateur et mise en place d'une interface de gestion simplifiée.
        
2. **Sécurité & RGPD :** Risque de fuite sur des données sensibles.
    
    - _Réduction :_ Activation systématique de l'authentification multi-facteurs (MFA) et chiffrement des données au repos. Utilisation des régions "France Central".
        
3. **Migration des données :** Risque de coupure de l'application métier.
    
    - _Réduction :_ Stratégie de "Blue-Green deployment" (on monte la nouvelle infra en parallèle et on bascule les DNS une fois les tests validés).
        
4. **Dépendance fournisseur (Lock-in) :**
    
    - _Réduction :_ Utilisation de technologies standards (MySQL, PHP) permettant de migrer vers un autre fournisseur (ex: OVH) si nécessaire à l'avenir.