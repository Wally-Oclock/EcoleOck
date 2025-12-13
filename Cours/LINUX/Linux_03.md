### LINUX_S3-3

**Comptes utilisateurs**
Un utilisateur identifie une personne ou un service sur la machine, Il possède :
• un identifiant numérique (UID)
• un groupe primaire (GID)
• un dossier personnel et un Shell par défaut
• des permissions distinctes de celles des autres utilisateurs.

/etc/passwd

![image-20251212092904890](Linux_03.images/image-20251212092904890.png)

cat /etc/passwd

cat /etc/passwd | echo ali (utilisateur)

(gecos) = complément d'informations n°tel, mail...

![image-20251212094204986](Linux_03.images/image-20251212094204986.png)

![image-20251212100702350](Linux_03.images/image-20251212100702350.png)

ls  /home et ls -lt /home pour afficher les users créés récemment.

![image-20251212105524962](Linux_03.images/image-20251212105524962.png)

Supprimer un utilisateur : userdel
sudo userdel jean
sudo userdel -r jean
• -r : supprime le home et la boite mail locale(/var/mail/user)
• vérifiez avant de supprimer : aucun processus en cours, pas de fichiers critiques

![image-20251212112222748](Linux_03.images/image-20251212112222748.png)

Les groupes servent à gérer les permissions.

![image-20251212112432315](Linux_03.images/image-20251212112432315.png)

cat /etc/group pour afficher les groupes.

![image-20251212113442292](Linux_03.images/image-20251212113442292.png)

![image-20251212113744052](Linux_03.images/image-20251212113744052.png)

cat etc/passwd = voir les users

cat etc/group = voir les groupes

pour retrouver les fichier son stocker
/etc/passwd = users
/etc/shadow = les pass

Retirer un utilisateur d'un groupe :

```
sudo gpasswd -delete jean reseau
```



Changer le groupe primaire d'un utilisateur :

```
sudo usermod -g devops jean
```

![image-20251212134016388](Linux_03.images/image-20251212134016388.png)

![image-20251212134200938](Linux_03.images/image-20251212134200938.png)

![image-20251212134314516](Linux_03.images/image-20251212134314516.png)

> [!NOTE]
>
> ls -l open_space/
>
> 📌 Ce que tu vas voir dans la sortie
> Chaque ligne correspond à un fichier ou un dossier, avec :
> • 	Droits (rwx)
> • 	Type (d = dossier, - = fichier)
> • 	Nombre de liens
> • 	Propriétaire
> • 	Groupe
> • 	Taille
> • 	Date de modification
> • 	Nom du fichier/dossier

![image-20251212134432680](Linux_03.images/image-20251212134432680.png)

![image-20251212135423288](Linux_03.images/image-20251212135423288.png)

Changer les droits : **chmod**
Deux syntaxes possibles : symbolique ou octale.

![image-20251212140554500](Linux_03.images/image-20251212140554500.png)

Utilisateurs
useradd, usermod, userdel => commandes utilisateurs
/etc/passwd => liste les utilisateurs
/etc/shadow => liste les mots de passe
Groupes
groupadd, groupdel
/etc/group => liste les groupes
pour ajouter un utilisateur à un groupe, on modifie l'utilisateur, pas le groupe
à la création, chaque user a un GID
Les groupes servent à faire des ensembles d’utilisateurs
Les groupes permettent de gérer les droits
Permissions
Une ressource ça a : un propriétaire, un groupe, et les autres
Les droits s’appliquent pour chacun de ces 3 acteurs
Chown => changer le propriétaire d’un groupe
Chmod => permet de changer les droits

![image-20251212143939866](Linux_03.images/image-20251212143939866.png)


Dans ces slides :

- pourquoi utiliser sudo plutôt que se connecter en root
- le fichier /etc/sudoers etses règles
- visudo , l'outil sûr pour modifier la configuration
- quelques démos à reproduire sur une VM Linux

![image-20251212145231641](Linux_03.images/image-20251212145231641.png)


**Comment ça marche ?**

- sudo vérifie l'utilisateur et son mot de passe
- lit /etc/sudoers et les fichiers du dossier /etc/sudoers.d/
- valide la commande demandée selon les règles
- passe l'environnement et le contexte précisés dans la config

![image-20251212150646380](Linux_03.images/image-20251212150646380.png)

**Points clés à retenir**

- sudo permet une élévation contrôlée et tracée des privilèges
- /etc/sudoers définit qui peut faire quoi et comment
- visudo protège la configuration en vérifiant la syntaxe
- privilégiez des règles minimales, testées, et loggez vos usages

