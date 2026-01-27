# Atelier Nagios

Suivez les différentes étapes ci-dessous, **en cas de problème merci de poster un message suffisamment détaillé sur le canal \*#entraide\*** de notre Slack de promo !

> Solo ou en groupe ?

Toutes les manipulations sont à effectuer en solo, sur votre serveur Proxmox. Mais vous pouvez vous mettre en groupe pour vous entraider.

> Durée de l’atelier ?

Une journée entière sera suffisante pour réaliser cet atelier pratique. Nous avons prévu un temps confortable qui vous permettra d'effectuer toutes les manipulations à votre rythme, tout en ayant la possibilité de revenir sur certains points si nécessaire cette fois !

<aside>

## **Prérequis**

Avant de commencer, assurez-vous d'avoir les éléments suivants :

- Une VM (ou un CT) avec Ubuntu 24.04 installé.
- Une VM Windows Client/Server
- Une VM/CT Ubuntu (pour simuler un agent sur linux)
- Un accès root ou des privilèges sur les machines.
- Une connexion internet pour télécharger les paquets nécessaires.

Nous allons simuler de l’activité sur les 2 VM a savoir la VM Windows Server et la VM Ubuntu “Client”. Nous aurons également une VM/CT Ubuntu afin de faire l’installation de Nagios Core.

</aside>

## **Introduction à Nagios Core**

Nagios Core est un logiciel de supervision open source permettant de surveiller l’état de vos systèmes, services et applications.

Dans cet atelier, nous allons installer Nagios Core 4.5.11 sur une machine Ubuntu 24.04.

Nous allons également configurer des utilisateurs, des groupes, et des services pour vous permettre de surveiller efficacement votre infrastructure.

# Etape 1 : Installation du Nagios Core

## **Étape 1.1 : Mise à jour de votre système**

Il est important de s'assurer que votre système est à jour avant d'installer de nouveaux paquets. Ouvrez un terminal et exécutez les commandes suivantes :

```bash
apt update
apt upgrade -y
```

Cela garantit que tous les paquets existants sont à jour.

## **Étape 1.2 : Installation des dépendances**

Nagios Core nécessite plusieurs dépendances, y compris Apache, PHP, et des outils de compilation. Pour les installer, utilisez la commande suivante :

```bash
apt install -y build-essential libgd-dev openssl libssl-dev unzip apache2 php libapache2-mod-php libperl-dev libpng-dev
```

<aside> Voici un résumé des paquets installés :

- `build-essential` : Contient les outils nécessaires pour la compilation.
- `libgd-dev` et `libpng-dev` : Bibliothèques graphiques nécessaires pour les graphiques dans Nagios.
- `openssl` et `libssl-dev` : Bibliothèques de sécurité pour la communication.
- `apache2` : Serveur web nécessaire pour afficher l'interface web de Nagios.
- `php` et `libapache2-mod-php` : PHP pour la gestion des scripts web.
- `libperl-dev` : Nécessaire pour le support des plugins Nagios en Perl. </aside>

## **Étape 1.3 : Téléchargement de Nagios Core 4.5.11**

Pour continuer notre installation, nous allons maintenant télécharger l'archive source de Nagios Core depuis le site officiel. Cette archive contient tous les fichiers nécessaires pour compiler et installer le logiciel sur votre système :

```bash
cd /tmp
wget <https://go.nagios.org/get-core/4-5-11>
```

## **Étape 1.4 : Décompression de l'archive et installation de Nagios Core**

Une fois l'archive téléchargée, décompressez là et entrez dans le dossier extrait :

```bash
tar -xvzf 4-5-11
cd nagios-4.5.11
```

Nous allons maintenant créer un utilisateur nagios et l'ajouter au groupe nagcmd. Ces commandes permettent de créer les utilisateurs et groupes nécessaires pour que Nagios fonctionne correctement avec les bonnes permissions.

```
useradd nagios
groupadd nagcmd
usermod -G nagcmd nagios
usermod -G nagcmd www-data
```

Ensuite, compilez et installez Nagios Core en exécutant les commandes suivantes :

```bash
./configure --with-httpd-conf=/etc/apache2/sites-available --with-command-group=nagcmd
```

Une fois le configure fait, vous aurez un listing de la configuration actuelle du site :

![image.png](attachment:60ef5c2e-a463-4e8d-8b13-ca7fe8ff1524:image.png)

Nous pouvons maintenant lancer l’installation avec la commande :

```html
make all
```

Il est possible que vous ayez une série d’erreur,

![image.png](attachment:0470267b-a378-4fc7-8945-50ecbdefc546:image.png)

pas de panique nous ce qui nous interesse c’est qu’a la fin nous ayons un `“Enjoy”`

![image.png](attachment:70a8e1f6-ceb5-4ea9-bad3-ab81f6da6793:image.png)

Si nous regardons la liste des commande que l’ont nous donne juste avant de cette enjoy, nous voyons la liste des commandes a lancer pour continuer notre installation :

![image.png](attachment:bd10d8e4-5603-47c9-91c4-f392249623f3:image.png)

Donc légitimement, l’étape suivante consiste à installer Nagios et  ses fichiers de configuration, **Attention la création des groupes et users doit être la première étape ! il n’y a déjà le compte Nagios qui existe donc elle doit faire ressortir un avertissement ou une erreur, pas d’inquiétude elle va actualiser les droits** :

```bash
make install-groups-users

make install
make install-init
make install-daemoninit

make install-config
make install-commandmode
```

<aside>

💡 Cette série de commandes va installer Nagios Core et ses fichiers de configuration nécessaires.

Vous remarquez que je ne fais pas l’installation des thèmes (que ce soit le exfoliation ou le ClassicUi, pas spécialement besoin même si l’exfoliation est installé par défaut) si les thèmes vous intéresse vous en trouvez plein ici : https://exchange.nagios.org/directory/Addons/Frontends-(GUIs-and-CLIs)/Web-Interfaces/Themes-and-Skins

</aside>

## **Étape 1.5 : Installation de l'interface web de Nagios**

L'interface web de Nagios est un outil essentiel qui offre une vue d'ensemble détaillée et en temps réel de l'état de vos systèmes supervisés.

Cette interface permet de surveiller facilement les performances, les alertes et les métriques de tous vos équipements et services depuis un tableau de bord centralisé.

Rappelez vous, c’est comme Zabbix, j’ai un outil de Monitoring ET un outil de supervision.

Pour l'installer, exécutez les commandes suivantes toujours dans le même répertoire :

```bash
make install-webconf
```

Ensuite, activez le module Apache nécessaire, ainsi que le site et redémarrez Apache :

```bash
a2enmod cgi
a2ensite nagios
systemctl restart apache2
```

## **Étape 1.6 : Création d'un utilisateur Nagios pour l'accès à l'interface web**

Pour accéder à l'interface web, vous devez créer un utilisateur et un mot de passe. Exécutez la commande suivante pour configurer un mot de passe pour l'utilisateur `nagiosadmin` :

```bash
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
```

Vous serez invité à entrer et confirmer un mot de passe pour l’utilisateur `nagiosadmin`. Ce sera l'utilisateur que vous utiliserez pour vous connecter à l'interface web de Nagios.

## **Étape 1.7 : Démarrage de Nagios**

Pour démarrer Nagios Core, exécutez la commande suivante :

```bash
systemctl start nagios
systemctl enable nagios
```

Cela lance Nagios et configure le service pour qu'il démarre automatiquement au démarrage de la machine.

## **Étape 1.8 : Vérification du bon fonctionnement de Nagios**

Accédez à l'interface web de Nagios via votre navigateur en vous rendant à l’adresse suivante :

```
http://<votre_adresse_ip>/nagios
```

Utilisez le nom d'utilisateur `nagiosadmin` et le mot de passe que vous avez configuré précédemment pour vous connecter.

![image.png](attachment:686e9253-e3b2-4f4b-9360-ef3a69265345:image.png)

<aside>

Attention !

L'installation n'est pas encore terminée !

En effet, bien que nous ayons configuré les composants de base, il nous reste encore plusieurs étapes cruciales à accomplir pour avoir un système Nagios pleinement fonctionnel.

Nous devons notamment installer les plugins nécessaires, configurer la surveillance des hôtes et des services, et mettre en place les notifications.

Ces éléments sont essentiels pour tirer pleinement parti des capacités de supervision de Nagios.

Pour information, sur votre interface Nagios une fois connecté dans les `Hosts`, vous verrez l’état :

![image.png](attachment:980967c8-7332-42d0-9aa7-c6b4eb3af9af:image.png)

</aside>

## **Étape 1.9 : Installation des plugins**

Les plugins Nagios sont essentiels car ils fournissent les fonctionnalités de base pour effectuer des vérifications sur les hôtes et services.

On installe les prérequis (certains sont déjà installés, c’est pas grave !) :

```bash
apt install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext
```

Pour les installer, téléchargez d'abord la dernière version des plugins Nagios et lancer l’installation :

```bash
cd /tmp
wget -O nagios-plugins.tar.gz $(wget -q -O - <https://api.github.com/repos/nagios-plugins/nagios-plugins/releases/latest>  | grep '"browser_download_url":' | grep -o 'https://[^"]*')
tar zxf nagios-plugins.tar.gz
cd /tmp/nagios-plugins-*/
./configure
make
make install
```

Une fois l'installation terminée, les plugins seront disponibles dans le répertoire `/usr/local/nagios/libexec/`.

Vous pouvez vérifier que les plugins sont correctement installés en listant le contenu du répertoire :

```bash
ls -l /usr/local/nagios/libexec/
```

Vous devriez voir une liste de fichiers exécutables correspondant aux différents plugins disponibles pour Nagios.

![image.png](attachment:e1c96849-ff0a-4f80-bec2-62d44e708fcc:image.png)

Ces plugins sont essentiels car ils permettront d'effectuer les vérifications sur vos hôtes et services.

<aside>

Attention, il est possible que le Ping ne fonctionne pas et affiche l'erreur suivante :

```
CRITICAL - Could not interpret output from ping command
```

Cette erreur est normale car la commande /bin/ping n'est exécutable que par l'utilisateur root. Comme l'utilisateur Nagios n'est pas root, il ne peut pas utiliser cette commande.

Pour résoudre ce problème, exécutez cette commande en tant que root :

```
chmod u+s /bin/ping
```

Une fois cette modification effectuée, le ping devrait fonctionner correctement.

![image.png](attachment:224824fc-426d-4cb7-803b-5bf4f4c20c01:image.png)

</aside>

## **Étape 1.9 : Configuration du pare-feu (facultatif)**

Si vous avez un pare-feu actif sur votre serveur Ubuntu, vous devrez peut-être autoriser l'accès à Apache. Vous pouvez le faire avec la commande suivante :

```bash
ufw allow 'Apache Full'
```

Cela permettra d'autoriser l'accès au serveur web depuis l'extérieur.

<aside>

> Vous avez maintenant installé Nagios Core 4.5.11 sur Ubuntu 24.04 et êtes prêt à commencer la surveillance de vos systèmes.

> Vous pouvez configurer des hôtes et des services à surveiller, ajouter des plugins Nagios, et personnaliser votre interface web selon vos besoins.

</aside>

# **Étape 2 : Installation de l'Agent NCPA sur une VM Windows Client/Server**

NCPA est un agent Nagios universel qui simplifie la configuration et prend en charge Windows, Linux et macOS.

Il expose une API RESTful pour l'interrogation des données, et son installation est plus simple et plus flexible que NRPE.

### **2.1 : Télécharger l'agent NCPA pour Windows**

1. Rendez-vous sur la page officielle de **NCPA** : [Téléchargement de NCPA](https://www.nagios.org/projects/ncpa/#downloads).
2. Sélectionnez **Windows** et téléchargez le fichier d'installation NCPA-Latest.exe.
3. Une fois le téléchargement terminé, exécutez le fichier `.exe` pour démarrer l'installation.

### **2.2 : Installation de l'Agent NCPA**

Lors de l'installation, vous devrez spécifier quelques paramètres :

1. **Accepter les termes de la licence**.
2. Choisissez **Install NCPA as a service** pour que l'agent démarre automatiquement.
3. Lorsqu'il vous est demandé de définir un token, entrez un token (c’est un mot). Ce token sera utilisé pour les connexions sécurisées à l'API de NCPA.

![image.png](attachment:7370c3e4-a8d7-41b0-aabb-5480699d3d96:image.png)

1. Acceptez les paramètres par défaut pour l'agent (comme l'activation du port `5693` pour la communication). N’activé pas non plus les checks passives vous pouvez directement faire next.
2. Terminez l'installation en cliquant sur **Install**.

### **2.3 : Vérification de l'installation de NCPA**

Une fois l'installation terminée, l'agent NCPA devrait être en cours d'exécution en tant que service sur votre serveur Windows. Pour vérifier cela :

1. Ouvrez le **Gestionnaire des tâches** et allez dans l'onglet **Services**.
2. Recherchez le service **NCPA**. Il devrait être en **"En cours d'exécution"**.

![image.png](attachment:c6b0799a-67aa-4dc4-ac7f-bcfa6e19cc17:image.png)

Si le service n’est pas en cours d’exécution, vous pouvez le démarrer manuellement.

### **2.4 : Configuration du pare-feu Windows (facultatif)**

Si le pare-feu est activé sur votre serveur Windows, assurez-vous d'ouvrir le port **5693** pour permettre la communication avec le serveur Nagios. Vous pouvez le faire en exécutant les commandes suivantes dans une fenêtre PowerShell avec des privilèges administratifs :

```powershell
New-NetFirewallRule -DisplayName "NCPA" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 5693
```

Cela ouvrira le port nécessaire pour l'API NCPA et la surveillance de l'agent.

### **2.5 : Test de l'agent NCPA**

L'agent NCPA expose une interface Web accessible via l'adresse IP de votre serveur Windows. Vous pouvez tester cette interface en ouvrant un navigateur et en accédant à :

```html
https://<IP_du_serveur_windows>:5693
```

Entrez le token que vous avez défini lors de l'installation pour accéder à l'interface web. Vous pourrez consulter les informations de performance de votre serveur Windows à travers cette interface.

![image.png](attachment:2b36f516-8403-4c59-8bab-94edf5c32cd5:image.png)

### **2.6 : Configuration de NCPA sur le serveur Nagios**

Maintenant que l'agent NCPA est installé et fonctionne, vous devez configurer votre serveur Nagios pour surveiller le serveur Windows.

<aside>

Petit rappel : n'oubliez pas que nous travaillons maintenant sur le serveur Nagios, celui qu'on a configuré juste avant ! 😊

</aside>

1. Accédez à la configuration de Nagios sur votre serveur Nagios (généralement situé dans `/usr/local/nagios/etc/`).
2. Créez un fichier de configuration pour votre serveur Windows dans le dossier **servers** (par exemple, `windows_server.cfg`).

```bash
cd /usr/local/nagios/etc/
mkdir servers
nano /usr/local/nagios/etc/servers/windows_server.cfg
```

1. Ajoutez la configuration suivante :

```bash
define host {
    use                     generic-host
    host_name               windows_server
    alias                   Windows Server
    address                 <IP_du_serveur_windows>
    check_command           check-host-alive
    max_check_attempts      5
    check_interval          1
    retry_interval          1
    check_period            24x7
    notification_interval   30
    notification_period     24x7
    contacts                nagiosadmin
}

define service {
    use                     generic-service
    host_name               windows_server
    service_description     CPU Load
    check_command           check_ncpa!-t MotDePasse -M cpu/percent
    normal_check_interval   5
    retry_check_interval    1
    notification_interval   30
}

define service {
    use                     generic-service
    host_name               windows_server
    service_description     Memory Usage
    check_command           check_ncpa!-t MotDePasse -M memory/virtual
    normal_check_interval   5
    retry_check_interval    1
    notification_interval   30
}
```

<aside>

### **Détails des paramètres :**

- **check_ncpa** : Utilise le plugin Nagios pour interroger l'agent NCPA.
- **<mot_de_passe>** : Remplacez `<mot_de_passe>` par le token que vous avez défini lors de l'installation de NCPA.
- **cpu, memory** : Ce sont des exemples de services surveillés. Vous pouvez ajouter d'autres services comme les disques, les processus, etc. en fonction de vos besoins. </aside>

1. Rechargez la configuration de Nagios pour appliquer les modifications :

```bash
systemctl restart nagios
```

Pour configurer correctement la surveillance NCPA, vous devez maintenant ajouter une définition de commande spécifique dans le fichier de configuration du serveur Nagios.

<aside>

**Ce changement est a faire une seul fois, si vous l’avez déjà avec Ubuntu vous n’avez pas besoin de le faire, vous deviez déjà l’avoir :**

Ouvrez le fichier `/usr/local/nagios/etc/objects/commands.cfg` et ajoutez la configuration suivante qui permettra à Nagios d'interagir avec l'agent NCPA :

```bash
define command {
    command_name    check_ncpa
    command_line    $USER1$/check_ncpa.py -H $HOSTADDRESS$ $ARG1$
}
```

</aside>

1. Une fois fait, vous devez mettre à jour la configuration dans le fichier `/usr/local/nagios/etc/nagios.cfg`. Décommentez la ligne `#cfg_dir=/usr/local/nagios/etc/servers` pour permettre la découverte des nouveaux serveurs. Sans cette étape, aucune vérification ni remontée d'information ne sera effectuée.

   ![image.png](attachment:037f205c-bd64-4c4e-a872-25277a73290e:image.png)

Une fois ces modifications effectuées, il est nécessaire de redémarrer le service Nagios pour que les changements prennent effet.

Cette étape est cruciale pour que Nagios puisse prendre en compte votre nouvelle configuration et commencer la surveillance des services que vous venez de définir.

```bash
systemctl reload nagios
```

### **2.7 : Vérification dans l'interface Web de Nagios**

Accédez à l'interface web de Nagios via l'URL suivante (en remplaçant `<votre_adresse_ip>` par l'adresse de votre serveur Nagios) :

```
http://<votre_adresse_ip>/nagios
```

Vérifiez que le serveur Windows est bien ajouté et que les services que vous avez configurés (comme la charge CPU et l'utilisation de la mémoire) sont correctement surveillés.

<aside>

> Vous avez installé et configuré avec succès l'agent NCPA sur un serveur Windows et ajouté ce serveur à Nagios Core pour le surveiller.

> Vous pouvez maintenant étendre la surveillance à d'autres services et hôtes en utilisant les fonctionnalités de NCPA.

</aside>

<aside>

> **Attention à cette étape : le plugin \*check_ncpa\* n’a pas encore été téléchargé ni installé.**
>
> De ce fait, les vérifications associées peuvent ne pas fonctionner correctement pour le moment, et aucune remontée d’information ne sera visible dans l’outil de supervision.
>
> Cela est tout à fait normal à ce stade de la procédure. L’installation et la configuration du plugin *check_ncpa* seront réalisées ultérieurement, dans le **paragraphe 3.6.3**, situé tout en bas de ce document.
>
> En attendant, vous pouvez poursuivre les étapes suivantes sans modifier la configuration actuelle et sans vous inquiéter des éventuels messages d’erreur ou de l’absence de données. Ceux-ci disparaîtront une fois le plugin correctement installé et opérationnel.

</aside>

# **Étape 3 : Installation de l'Agent NCPA sur un Nouveau Serveur Ubuntu 24**

L'agent NCPA est compatible avec Ubuntu 24 et peut être installé facilement via un fichier `.deb`. Nous allons suivre les étapes nécessaires pour installer l'agent NCPA et le configurer pour la surveillance via Nagios.

### **3.1 : Télécharger l'agent NCPA pour Ubuntu**

Vous pouvez télécharger directement le fichier avec `APT` :

```bash
# Add to the apt sources list
echo "deb <https://repo.nagios.com/deb/$>(lsb_release -cs) /" > /etc/apt/sources.list.d/nagios.list

# Add missing package
apt install gnupg gnupg2 gnupg1

# Add our public GPG key
wget -qO - <https://repo.nagios.com/GPG-KEY-NAGIOS-V3> | apt-key add -

# Update your repositories
apt update
```

### **3.2 : Installation de NCPA sur Ubuntu**

Une fois que le dépôt a été correctement ajouté et mis à jour dans votre système, nous pouvons procéder à l'installation de l'agent NCPA.

Pour installer l'agent NCPA sur votre système Ubuntu, exécutez la commande suivante dans votre terminal  :

```bash
apt install ncpa
```

### **3.3 : Configuration de NCPA sur Ubuntu**

L'agent NCPA est maintenant installé, mais avant de pouvoir l'utiliser pour la surveillance via Nagios, nous devons le configurer. Cela inclut la configuration du mot de passe de l'API et la vérification des paramètres de connexion.

1. **Configurer le mot de passe de l'API** : À l'installation de NCPA, un mot de passe d'API est généré automatiquement. Pour définir votre propre mot de passe sécurisé, modifiez le fichier de configuration :

2. `nano /usr/local/ncpa/etc/ncpa.cfg` Puis remplacez la ligne : `community_string = mytoken` par votre mot de passe

   Cela vous permettra de modifier le mot de passe pour l'accès à l'API NCPA. Assurez-vous de choisir un mot de passe sécurisé, car il sera utilisé pour toutes les connexions API de Nagios.

3. **Vérifier le port d'écoute** : NCPA écoute par défaut sur le port **5693**. Si vous avez un pare-feu en place, vous devez vous assurer que ce port est ouvert.

   Pour ouvrir le port sur **UFW**, vous pouvez exécuter la commande suivante :

   ```bash
   ufw allow 5693/tcp
   ```

4. **Démarrer le service NCPA** : NCPA doit être exécuté en tant que service sur votre serveur Ubuntu. Il est généralement démarré automatiquement après l'installation, mais pour vérifier ou démarrer le service manuellement, utilisez :

   ```bash
   systemctl start ncpa
   systemctl enable ncpa
   ```

   Vous pouvez vérifier le statut du service avec :

   ```bash
   systemctl status ncpa
   ```

### **3.4 : Tester l'interface Web de NCPA**

L'interface web de NCPA vous permet de vérifier que l'agent fonctionne correctement et d'accéder aux données de performance.

Pour y accéder, ouvrez un navigateur et entrez l'adresse suivante (remplacez `<IP_du_serveur_ubuntu>` par l'adresse IP de votre serveur Ubuntu) :

```
https://<IP_du_serveur_ubuntu>:5693
```

Lorsque vous y accédez, vous serez invité à entrer le mot de passe que vous avez configuré à l'étape précédente pour accéder aux informations de surveillance du serveur.

![image.png](attachment:1efb7451-5942-4447-99f1-343f5b891451:image.png)

Une fois connecté à l'interface, vous aurez accès à un tableau de bord complet qui vous permettra de visualiser les différents contrôles et données collectées sur le nouveau serveur.

![image.png](attachment:f26201c2-9cf4-4b6d-9083-ecc410dd7f31:image.png)

Il est important de noter que pour le moment, l'interface peut sembler vide ou limitée en informations - ceci est tout à fait normal car l'installation vient d'être effectuée.

Cette situation est temporaire et nous devrons procéder à des étapes de configuration supplémentaires pour activer la collecte et l'affichage des données de surveillance que nous souhaitons obtenir.

### **3.5 : Configuration de NCPA pour Nagios**

Maintenant que l'agent NCPA est installé et fonctionne sur votre serveur Ubuntu, il est temps de le configurer sur votre serveur Nagios pour qu'il puisse surveiller ce serveur. Vous allez ajouter ce serveur à la configuration de Nagios et commencer à surveiller ses services.

<aside>

Petit rappel : n'oubliez pas que nous travaillons maintenant sur le serveur Nagios, celui qu'on a configuré en premier ! 😊

</aside>

1. Sur votre serveur Nagios, allez dans le répertoire des configurations Nagios, généralement situé dans `/usr/local/nagios/etc/servers/`.
2. Créez un fichier de configuration pour votre serveur Ubuntu dans le dossier **servers** (par exemple, `ubuntu_server.cfg`).

```bash
cd /usr/local/nagios/etc/
mkdir servers (normalement c'est fait dans l'étape Windows)
nano /usr/local/nagios/etc/servers/ubuntu_server.cfg
```

1. Ajoutez la configuration suivante :

```bash
define host {
    use                     generic-host
    host_name               ubuntu_server
    alias                   Ubuntu Server
    address                 <IP_du_serveur_ubuntu>
    check_command           check-host-alive
    max_check_attempts      5
    check_interval          1
    retry_interval          1
    check_period            24x7
    notification_interval   30
    notification_period     24x7
    contacts                nagiosadmin
}

define service {
    use                     generic-service
    host_name               ubuntu_server
    service_description     CPU Load
    check_command           check_ncpa!-t MotDePasse -M cpu/percent
    normal_check_interval   5
    retry_check_interval    1
    notification_interval   30
}

define service {
    use                     generic-service
    host_name               ubuntu_server
    service_description     Memory Usage
    check_command           check_ncpa!-t MotDePasse -M memory/virtual
    normal_check_interval   5
    retry_check_interval    1
    notification_interval   30
}
```

Pour configurer correctement la surveillance NCPA, vous devez maintenant ajouter une définition de commande spécifique dans le fichier de configuration Nagios.

<aside>

**Ce changement est a faire une seul fois, si vous l’avez déjà avec Windows vous n’avez pas besoin de le faire, vous deviez déjà l’avoir :**

1. Une fois fait, vous devez mettre à jour la configuration dans le fichier `/usr/local/nagios/etc/nagios.cfg`. Décommentez la ligne `#cfg_dir=/usr/local/nagios/etc/servers` pour permettre la découverte des nouveaux serveurs. Sans cette étape, aucune vérification ni remontée d'information ne sera effectuée.

   ![image.png](attachment:037f205c-bd64-4c4e-a872-25277a73290e:image.png)

Ouvrez le fichier `/usr/local/nagios/etc/objects/commands.cfg` et ajoutez la configuration suivante qui permettra à Nagios d'interagir avec l'agent NCPA :

```bash
define command {
    command_name    check_ncpa
    command_line    $USER1$/check_ncpa.py -H $HOSTADDRESS$ $ARG1$
}
```

</aside>

1. Rechargez la configuration de Nagios pour appliquer les modifications :

```bash
systemctl reload nagios
```

1. Vous devez maintenant installer le script check_ncpa.py, qui est un composant essentiel permettant à Nagios de communiquer avec l'agent NCPA et d'effectuer les vérifications des services. Ce script agit comme une interface entre Nagios Core et l'agent NCPA, facilitant la collecte et la transmission des données de surveillance.

```bash
# On télécharge Check_ncpa
wget <https://raw.githubusercontent.com/NagiosEnterprises/ncpa/master/client/check_ncpa.py> -O /usr/local/nagios/libexec/check_ncpa.py

# On change les droits du fichier, on met le 777, on devrait affiné les droits pour plus de sécurité
chmod 777 /usr/local/nagios/libexec/check_ncpa.py

# NCPA fonctionne avec python, mais avec la commande "python", sur les nouvelles distribution
# Nous n'avons plus "python" seul, mais "python3" le paquet suivant permet de faire fonctionner
# "python" avec "python3" 
apt install python-is-python3
```

<aside>

Si vous voulez tester l’outil hors nagios :

```
/usr/local/nagios/libexec/check_ncpa.py -H <IP_DU_NCPA> -t <Token> -M 'processes' --warning=100 --critical=200
```

par exemple :

![image.png](attachment:2941c320-8826-4ff8-9058-ad40f6a98e4c:image.png)

</aside>

### **3.6 : Vérification de la surveillance dans l'interface Web de Nagios**

Accédez à l'interface web de Nagios pour vérifier que votre serveur Ubuntu et ses services sont maintenant surveillés. Ouvrez un navigateur et allez à l'adresse suivante (en remplaçant `<votre_adresse_ip>` par l'adresse de votre serveur Nagios) :

```
https://<votre_adresse_ip>/nagios
```

Vous devriez voir le serveur Ubuntu et ses services (CPU et mémoire) dans la liste des hôtes surveillés.

![image.png](attachment:70f2961d-4943-4acc-b9d0-2c12eb9141d0:image.png)

<aside>

> Vous avez maintenant installé et configuré l'agent NCPA sur un serveur Ubuntu 24 et ajouté ce serveur à Nagios pour le surveiller.

> Vous pouvez maintenant étendre la surveillance en ajoutant d'autres services ou en ajustant la configuration de NCPA selon vos besoins.

</aside>