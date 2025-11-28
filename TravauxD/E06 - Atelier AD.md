### E06 - Atelier AD

Rentrée scolaire :

## Structure de l’Active Directory

- **Oclock (Forêt)**
  - **Promotion**
    - Patrice MALDI (Utilisateur)
    - GS_Promotions (Groupe)
    - Andromède
      - Baptiste DELPHIN (Utilisateur)
      - GS_PromoAndromede (groupe)
    - Aldebaran
      - Christophe SEIGNANT (Utilisateur)
      - GS_PromoAldebaran (groupe)
    - Zinc
      - Roman BELDENT (Utilisateur)
      - GS_PromoZinc (groupe)
    - Basilic
      - Alice MARTIN (Utilisateur)
      - GS_PromoBasilic (groupe)

Création de l'unité organisationnelle Zink et Basilic dans Promotion :

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\UO-zink.png)

Création des groupes GS_Promo :

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\grpromoZink.png)

Création des utilisateurs :

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\utilisateur.png)

Ajouter un utilisateur à son groupe :

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\user-gr.png)

GPO pour tous les étudiants : Création d'une gpo pour tous les étudiants de la promo. Pour cela il faut  une gpo implémentée dans une configuration ordinateur, Préférences, Paramètres Windows et registre. Le but est de modifier la clef et la mettre sur la valeur 2 pour l'activer.

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\gpoVerrNUM.png)

**Configurer une politique de mot de passe sécurisé**

Pour activer la gpo de la stratégie des mdp complexe et forcer le changement tous les  30 jours:

Pour faire cette configuration, tout d'abord il faut la créer dans une configuration ordinateur, paramètres windows, paramètres de sécurité et stratégie de mot de passe.

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\gpo-mdp.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\gpo-mdp-mini.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\gpo-mdp-30j.png)

### GPO spécifique par promotion :

- **Forcer un fond d’écran**

Pour créer une GPO par promo, il faut passer par une configuration utilisateur. Ensuite modèle d'administration et bureau.

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\GPOfondEcran.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\gpowallpapaer.png)

**Désactiver la connexion des étudiants Zinc et Basilic à partir de 17h jusqu’à 8h00 pour tout les jours de la semaine**.

Cette configuration pour restreindre les horaires de connexion peut se faire dans l'AD de façon ciblée et individuelle comme par GPO pour toute une promo. Ici, la config par tranche horaire se fait dans la fenêtre de configuration Utilisateur.

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\restreindreAD.png)

1. Exécutez → gpmc.msc et créez un nouveau GPO appelé « Restrictions de connexion ». Faites un clic droit sur ce GPO et cliquez sur GPO.
2. Accédez à Configurations de l'ordinateur → Stratégies → Paramètres Windows → Paramètres de sécurité → Stratégies locales → Options de sécurité.

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\restreindreADgpo.png)

Partages de dossiers : Création de dossiers partagés pour chaque promotion :

- Crée un dossier partagé pour chaque promotion (Aldebaran, Andromède, Zinc, Basilic).
- Configure les permissions de partage et NTFS pour que seuls les membres du groupe approprié aient accès.

- `Serveur//Shares//PromoAldebaran`
- `Serveur//Shares//PromoAndromede`
- `Serveur//Shares//PromoZinc`
- `Serveur//Shares//PromoBasilic`

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\partageBasilic.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\partageBasilicAutoris.png)

Utilisation du chemin UNC pour l'accès au réseau

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\ajoutadressdossierbasilic.png)

- Attribuer un mappage pour chaque dossier

- Restreindre les fichiers

  - Interdit aux fichiers ***.divx*** uniquement

  - Dans le gestionnaire de ressources du serveur, j'ai ajouté un filtre qui interdit aux utilisateurs tout fichier vidéo avec extention . divx.

    ![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\divexInterdit.png)

- Quotas de 30Go par promotions

  Dans l'éditeur de cible, choisir ciblage d'élément et Groupe de sécurité

  ![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\elementciblebasilic.png)

Ce filtre cible les utilisateurs du groupe Basilic et s'applique seulement si l'utilisateur fait partie du **groupe de sécurité**.

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\elementciblebasilic2.png)

Sur le pc client, j'ai ouvert le cmd pour forcer la gpo du partage : gpupdate /force

Résultat : le lecteur réseau partagé s'est affiché chez le client.

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\lecteurmappeaffiche.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\quota1.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\quota30gotous.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\quota30client.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\firefox&fondecran.png)

**Bonus Extremes ! : Mettre des profils itinérants & Installation de VSCode.**

- Créer un nouveau Partage, pour les profils itinérants (Pas d’inquiétude en correction nous allons en parlera correctement 😉 ).
  - Et créer les pour chaque utilisateur de l’AD

- [**Obligation d’installer VSCode**](https://github.com/letsdoautomation/group-policy/tree/main/Deploy Visual Studio Code) : Crée une GPO pour déployer Visual Studio Code sur les machines des étudiants **Zinc & Basilic uniquement**.
- ![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\partageitinerants.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\Droitspartageitinerants.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\DroitsAvanceespartageitinerants.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\PROFILITINERANTS.png)

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\PROFILITINERANTSdossier.png)

TEST : création du dossier test et déconnexion de l'utilisateur

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\PROFILITINERANTSTEST.png)

Install WSCODE 1ère étape conversion de l'exe en msi

![](F:\GitHub\EcoleOck\TravauxD\Atelier-AD\E06 - Atelier AD.images\vscodeok.png)