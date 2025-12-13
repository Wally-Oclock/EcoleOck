# Permissions Unix & gestion utilisateurs et groupes sur GNU/Linux

Dernière modification: 5 mars 2025

# GNU/Linux : Gestion utilisateurs, groupes, et permissions Unix

## Gestion des utilisateurs

### Fichier `/etc/passwd`

Ce fichier contient la liste des utilisateurs (y compris les utilisateurs « système », avec lesquels on ne peut pas se connecter).

Chaque ligne de ce fichier est un utilisateur.

Structure de chaque ligne :

```
root:x:0:0:root:/root:/bin/bash
```

root : nom d’utilisateur x : présence d’un mot de passe haché dans le fichier /etc/shadow 0 : UID (User ID) 0 : GID (Group ID) root : commentaire, facultatif /root : emplacement du dossier personnel de l’utilisateur /bin/bash : shell par défaut pour cet utilisateur

L’utilisateur root est toujours le premier utilisateur du système, il a l’ID 0. C’est le super-utilisateur (administrateur).

Tous les users qui ont un ID inférieur à 1000 sont des utilisateurs système. Ces utilisateurs ont le shell `nologin`, ce qui indique qu’on ne peut pas se connecter avec.

Le premier utilisateur, créé pendant l’installation, a l’ID 1000.

### Fichier /etc/shadow

Ce fichier contient les mots de passe hachés (et salés) de nos utilisateurs.

Les utilisateurs système n’ont pas de mot de passe, vu qu’on ne peut pas se connecter avec.

⚠️ Ce fichier est très sensible ! Il ne faut pas modifier ses permissions, pour s’assurer qu’un hacker ne puisse pas y avoir accès.

### Création/modification d’utilisateurs

Pour créer un nouvel utilisateur, on utilise la commande `useradd` :

```ebnf
useradd -m alice
```

💡 L’argument `-m` permet de créer automatiquement le dossier personnel de l’utilisateur.

Pour ajouter un mot de passe à notre utilisateur (ou modifier un mot de passe existant), on utilise la commande `passwd` :

```ebnf
passwd alice
```

Si on veut modifier le shell utilisé par un utilisateur, on va utiliser la commande `usermod` :

```awk
usermod -s /bin/bash alice
```

💡 Pour supprimer un utilisateur, il faut utiliser la commande `userdel`.

### Historique

Avec le shell bash, l’historique des commandes tapées est stocké dans le fichier `~/.bash_history`.

💡 On peut consulter l’historique récent avec la commande `history`.

💡 On peut faire une recherche dans l’historique avec le raccourci `Ctrl+R`.

## Gestion des groupes

Créer un groupe : `groupadd`

Par exemple, pour créer un groupe `compta` avec deux utilisateurs dedans :

```mipsasm
groupadd -U alice,bob compta
```

Modifier un groupe : `groupmod`

Supprimer un groupe : `groupdel`

## sudo / su

La commande `sudo` (Substitute/Switch User DO) permet de lancer une commande en tant qu’un autre utilisateur. Par défaut, ce sera en tant que le compte super-utilisateur (root).

⚠️ Par défaut, `sudo` n’est pas installé sur Debian …

Il va falloir installer `sudo`, mais pour installer un paquet, il faut avoir les droits du super-utilisateur …

On va utiliser la commande `su` (Switch User) qui permet de changer d’utilisateur !

```nginx
su -
```

💡 l’argument `-` permet de charger des variables d’environnement propre à l’utilisateur avec lequel on va se connecter. Si on ne précise pas avec quel utilisateur on veut switcher, on se connectera en tant que le super-utilisateur `root`.

Une fois connecté en `root`, on peut installer `sudo` :

```cmake
apt update
apt install sudo
```

Pour revenir à notre utilisateur standard, on peut taper la commande `exit`.

Si on essaye de lancer `sudo ...` après l’avoir installé, on va avoir une erreur : `username n'est pas dans le fichier sudoers.`.

Pour qu’on puisse utiliser la commande `sudo`, il faut avoir été autorisé à le faire par le super-utilisateur, et ça se passe dans le fichier `/etc/sudoers`.

### Fichier /etc/sudoers

Pour modifier `/etc/sudoers`, on doit utiliser une commande spécifique : `visudo`.

💡 Sur Debian 12, `visudo` nous permet d’éditer le fichier `sudoers` avec l’éditeur `nano`, mais ce n’est pas le cas sur toutes les distributions !

Si on veut changer l’éditeur utilisé par `visudo`, on peut lancer la commande suivante :

```ini
EDITOR=nano visudo
```

Structure d’une ligne dans le fichier `/etc/sudoers` :

```
root ALL=(ALL:ALL) ALL
```

root : nom d’utilisateur ou nom du groupe si précédé par `%` 1er ALL : désigne la machine sur laquelle on veut autoriser l’utilisateur a lancer des commandes 2ème ALL : le premier ALL entre parenthèse décrit l’utilisateur qu’on va avoir le droit d’impersonnifier 3ème ALL : le deuxième ALL entre parenthèse décrit un groupe d’utilisateur qu’on pourrait impersonnifier 4ème ALL : décrit les commandes qu’on va avoir le droit de lancer avec sudo

💡 En général, on ne modifie pas les 3 premiers ALL. Par contre, on peut modifier le dernier pour indiquer explicitement quelle commande sont autorisées pour nos utilisateurs.

Par exemple, si on veut autoriser l’utilisateur Alice à éteindre l’ordinateur :

```
alice ALL=(ALL:ALL) /sbin/shutdown, /bin/cat /etc/shadow
```

On peut autoriser un utilisateur a lancer une commande avec `sudo` sans avoir besoin de saisir un mot de passe. Pour ça, on rajoute l’instruction `NOPASSWD` à la ligne dans le fichier `sudoers`.

```
alice ALL=(ALL:ALL) NOPASSWD: /bin/cat /etc/shadow
```

En général, sur la plupart des systèmes GNU/Linux que vous aller croiser, il n’y aura souvent qu’un seul utilisateur (vous !) et donc pas besoin de faire une configuration complexe (d’autoriser chaque commande explicitement).

On va souvent autoriser notre utilisateur a lancer n’importe quelle commande en tant que root, en ayant besoin de saisir le mot de passe (pour des raisons de sécurité).

```
alice ALL=(ALL:ALL) ALL
```

Encore mieux ! On a une ligne `%sudo ALL=(ALL:ALL) ALL` déjà présente. Cette ligne autorise tous les membres du groupe `sudo` a lancer des commandes `sudo`.

Il nous suffit donc d’ajouter notre utilisateur à ce groupe pour qu’il puisse lancer des commandes `sudo`. Pour ajouter un utilisateur à un groupe, on utilise la commande `usermod` :

```ebnf
usermod -aG sudo alice
```

⚠️ Une fois cette commande lancée, il faudra se déconnecter de l’utilisateur alice et se reconnecter pour que la modification soit prise en compte.

💡 On peut vérifier les groupes dans lesquels notre utilisateur se trouve avec la commande `groups`.

💡 On peut consulter les autorisations `sudo` de notre utilisateur avec la commande `sudo -l`.

### Dossier /etc/sudoers.d

Sur des configurations complexes, pour éviter de « surcharger » le fichier `/etc/sudoers`, on peut créer d’autres fichiers avec nos instructions (par exemple `alice ALL=(ALL:ALL) ALL`) dans le dossier `/etc/sudoers.d`. Tous ces fichiers, quelque-soit leur nom, seront automatiquement lus et chargés.

## Permissions Unix

Quand on lance la commande `ls -alh`, on peut visualiser les permissions des fichiers/dossiers et l’utilisateur propriétaire ainsi que le groupe propriétaire pour chaque fichier/dossier.

Exemple :

```tap
drwx------ 3 baptiste baptiste 4,0K 5 mars 11:56 .
drwxr-xr-x 4 root     root     4,0K 5 mars 11:11 ..
-rw-r--r-- 1 baptiste baptiste  266 5 mars 11:56 .bashrc
```

Première colonne : permissions (droits de lecture, écriture ou exécution) Deuxième colonne : on peut l’ignorer ! Troisième colonne : utilisateur propriétaire Quatrième colonne : groupe propriétaire Cinquième colonne : estimation de la taille (attention, souvent faux) Sixième colonne : date de dernière modification Septième colonne : nom du fichier/dossier

### Les permissions en détail

Par exemple, pour un fichier on peut voir `drwxr-xr-x`.

La première lettre, c’est le type de fichier !

- `d` pour un dossier
- `-` pour un fichier
- `l` pour un lien symbolique (raccourci vers un autre fichier/dossier)

Les trois lettres suivantes, c’est les permissions de l’utilisateur propriétaire du fichier/dossier.

Les trois lettres d’après, c’est les permissions du groupe propriétaire du fichier/dossier.

Les trois dernières lettres, c’est les permissions de tous les autres utilisateurs, qui ne sont ni propriétaire du fichier/dossier, ni ne font partie du groupe propriétaire.

Pour chaque bloc de 3 lettres, on a les possiblités suivantes :

- `rwx` : droit de lire (`r`), droit d’écrire/modifier (`w`), droit d’exécuter le script (`x`)
- `rw-` : droit de lire (`r`), droit d’écrire/modifier (`w`)
- `r-x` : droit de lire (`r`), droit d’exécuter le script (`x`)
- `r--` : droit de lire (`r`) …

La première lettre d’un bloc de permissions sera forcément `r` ou `-`. La deuxième lettre d’un bloc sera forcément `w` ou `-`. La troisième lettre d’un bloc sera forcément `x` ou `-`.

⚠️ En réalité, il y a d’autres possibilités, mais c’est plus rare donc on en parlera plus tard.

### Changer les permissions : chmod

Pour modifier les permissions (les fameux `rwx` vus juste avant) sur un fichier/dossier, on utilise la commande `chmod`.

```awk
sudo chmod <nouvelles_permissions> /chemin/vers/dossier/ou/fichier
```

Il y a deux façons de spécifier ces :

- en octal
- avec des lettres

#### Méthode avec des lettres

On va remplacer dans la commande `chmod` avec des lettres permettant d’indiquer les modifications qu’on veut effectuer.

On peut modifier les permissions pour le propriétaire (lettre `u` comme user), pour le groupe propriétaire (lettre `g` comme groupe), pour tous les autres utilisateurs (lettre `o` comme other), ou pour tout le monde d’un seul coup (lettre `a` comme all).

On peut ajouter de nouvelles permissions (caractère `+`), supprimer des permissions (caractère `-`), ou définir les permissions (en ignorant les permissions précédentes, caractère `=`).

Et pour indiquer quelles permissions ajouter/supprimer/définir, on utilise les caractères `r`, `w` et `x`.

On peut donner plusieurs instructions d’un seul coup, séparées par des virgules.

Par exemple :

- ajouter le droit d’écriture au propriétaire : `u+w`
- ajouter le droit d’écriture au propriétaire et au groupe : `u+w,g+w`
- ajouter le droit d’écriture au propriétaire et au groupe (autre façon de faire) : `a+w,o-w`
- ajouter le droit d’écriture à tout le monde : `a+w`
- définir toutes les permissions possibles pour tout le monde : `a=rwx`
- enlever le droit d’exécution aux autres utilisateurs : `o-x`
- définir toutes les permissions possibles pour l’utilisateur, et seulement la permission de lecture pour les autres : `u=rwx,g=r,o=r`
- définir toutes les permissions possibles pour l’utilisateur, et seulement la permission de lecture pour les autres (autre façon) : `a=rwx,g-wx,o-wx`

Exemple, si je créé un dossier `/srv/compta` appartenant à l’utilisateur `root`, je peux autoriser tous les utilisateurs à écrire dans ce dossier avec la commande :

```awk
sudo chmod a+w /srv/compta
```

💡 On peut utiliser l’argument `-R` pour définir les permissions de façon récursive (c’est à dire donner les mêmes permissions également aux sous-dossiers et fichiers dans le dossier ciblé).

#### En octal

Pour définir les permissions en octal, on va utiliser la même commande `chmod` mais en utilisant 3 chiffres.

Exemple :

```awk
sudo chmod XYZ /srv/compta
```

Le premier chiffre (`X` dans l’exemple ci-dessus) correspond aux permissions du propriétaire. Le deuxième chiffre (`Y` ci-dessus) correspond aux permissions du groupe propriétaire. Le troisième chiffre (`Z` ci-dessus) correspond aux permissions des autres utilisateurs.

Pour choisir le chiffre à utiliser, on fait une addition !

- 4 : droit de lecture
- 2 : droit d’écriture
- 1 : droit d’exécution

Pour donner tous les droits (lecture, écriture et exécution), on utilise le chiffre `7` (4+2+1). Pour donner seulement le droit de lecture et d’écriture, on utilise le chiffre `6` (4+2). Pour donner seulement le droit de lecture et d’exécution, on utilise le chiffre `5` (4+1). etc.

Pour donner aucune permissions/droit, on utilise le chiffre `0`.

Exemple, si je créé un dossier `/srv/compta` appartenant à l’utilisateur `root`, je peux autoriser tous les utilisateurs à écrire dans ce dossier avec la commande :

```awk
sudo chmod 776 /srv/compta
```

On obtiendra dans ce cas là les permissions `rwxrwxrw-`.

### Changer le propriétaire / le groupe avec chown/chgrp

Pour changer le propriétaire d’un fichier/dossier, on utilise la commande `chown` :

```awk
sudo chown <nom_utilisateur> /chemin/vers/fichier/ou/dossier
```

Il faut remplacer par le nom du nouveau propriétaire du fichier/dossier.

💡 On peut également modifier en même le groupe propriétaire :

```awk
sudo chown <nom_utilisateur:nom_groupe> /chemin/vers/fichier/ou/dossier
```

Par exemple, pour dire que le dossier `/srv/compta` appartient à l’utilisateur `alice` et au groupe `compta` (il faut avoir créé le groupe `compta` au préalable) :

```awk
sudo chown alice:compta /srv/compta
```

💡 On peut utiliser l’argument `-R` pour changer le propriétaire de façon récursive.

La commande `chgrp` permet uniquement de modifier le groupe propriétaire :

```awk
sudo chgrp compta /srv/compta
```