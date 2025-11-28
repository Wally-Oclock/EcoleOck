#### Correction E06 - Atelier AD

Création des UO, utilisateurs et groupes

![image-20251127092122367](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251127092122367.png)

Ajouter les 4 groupes au grand groupe Promotion.

![image-20251127092658811](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251127092658811.png)

Activation clavier numérique en GPO à mettre en configuration ordinateur

![image-20251127095546742](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251127095546742.png)

![image-20251127102033192](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251127102033192.png)

GPO mot de passe il faut la gérer obligatoirement à la racine, dans le domaine avec Default Domain Policy.

Le PSO password object de windows server pour faire une politique spécifique c'est possible aussi sur WS. Pour le faire, il faut avant désactiver la gpo mdp. https://www.it-connect.fr/strategie-de-mot-de-passe-affinee-sous-windows-server-2012-r2/

![image-20251127105954292](Correction E06 - Atelier AD.images/image-20251127105954292.png)

![image-20251127112053586](Correction E06 - Atelier AD.images/image-20251127112053586.png)

Recommandation de la CNIL : minimum 12 caractères Mj, Symbl, C.spéciaux

Créer une GPO fond d'ecran par promo

![image-20251127114701330](Correction E06 - Atelier AD.images/image-20251127114701330.png)

Paramètres utilisateur

![image-20251127115300028](Correction E06 - Atelier AD.images/image-20251127115300028.png)

Les autorisations de partage

![image-20251127132102009](Correction E06 - Atelier AD.images/image-20251127132102009.png)

Désactiver la connexion des Zink et Basilc de 17h à 8h

Ce n'est pas une GPO mais il y a des paramètres qu'on peut forcer par gpo.

Dans utilisateurs et ordinateurs, propriétés du compte

![image-20251127133104257](Correction E06 - Atelier AD.images/image-20251127133104257.png)

ou sur nouveau espace (centre d'administration)

![image-20251127133320550](Correction E06 - Atelier AD.images/image-20251127133320550.png)

Avec une limitation horaires LoginOut

![image-20251127134210537](Correction E06 - Atelier AD.images/image-20251127134210537.png)

Partages des dossiers :

![image-20251127134712198](Correction E06 - Atelier AD.images/image-20251127134712198.png)

Retirer l'héritage et supprimer utilisateurs pour ajouter la promo

![image-20251127135448727](Correction E06 - Atelier AD.images/image-20251127135448727.png)

![image-20251127135511378](Correction E06 - Atelier AD.images/image-20251127135511378.png)

Mappage

![image-20251127135913947](Correction E06 - Atelier AD.images/image-20251127135913947.png)

Cliquer droit et créer ensuite ciblage

![image-20251127140021567](Correction E06 - Atelier AD.images/image-20251127140021567.png)

![image-20251127140038962](Correction E06 - Atelier AD.images/image-20251127140038962.png)

![image-20251127140051735](Correction E06 - Atelier AD.images/image-20251127140051735.png)

![image-20251127140101541](Correction E06 - Atelier AD.images/image-20251127140101541.png)

![image-20251127140134032](Correction E06 - Atelier AD.images/image-20251127140134032.png)

Restrictions divx et Quotas :

![image-20251127140340350](Correction E06 - Atelier AD.images/image-20251127140340350.png)

![image-20251127140321811](Correction E06 - Atelier AD.images/image-20251127140321811.png)

![image-20251127140510375](Correction E06 - Atelier AD.images/image-20251127140510375.png)

![image-20251127140631738](Correction E06 - Atelier AD.images/image-20251127140631738.png)

Modèle filter et ajouter divx

![image-20251127140815079](Correction E06 - Atelier AD.images/image-20251127140815079.png)

Pour l'affecter aux dossiers

![image-20251127140854977](Correction E06 - Atelier AD.images/image-20251127140854977.png)

![image-20251127140909349](Correction E06 - Atelier AD.images/image-20251127140909349.png)

Pour les 4 promos

![image-20251127141112879](Correction E06 - Atelier AD.images/image-20251127141112879.png)

Créer un modèle de Quotas

![image-20251127141240825](Correction E06 - Atelier AD.images/image-20251127141240825.png)

Ajouter les logs pour vérifier (optionnel)

![image-20251127141401331](Correction E06 - Atelier AD.images/image-20251127141401331.png)

Appliquer les Quotas de 30 Go aux promos

![image-20251127141605523](Correction E06 - Atelier AD.images/image-20251127141605523.png)

![image-20251127141451083](Correction E06 - Atelier AD.images/image-20251127141451083.png)

![image-20251127141618471](Correction E06 - Atelier AD.images/image-20251127141618471.png)

En mettant le dossiers racine Shares avec Quotas, chaque fois qu'un dossier est créé, il aura ce quota de 30Go (il faut actualiser)

![image-20251127142218974](Correction E06 - Atelier AD.images/image-20251127142218974.png)

![image-20251127142453927](Correction E06 - Atelier AD.images/image-20251127142453927.png)

Test pour coller un fichier Divx

![image-20251127142630654](Correction E06 - Atelier AD.images/image-20251127142630654.png)

Installer en déployant FireFox et Chrome (obligation d'un MSI) mais...

Créer un nouveau partage Application ($) je laisse les droits par défaut

![image-20251127143231272](Correction E06 - Atelier AD.images/image-20251127143231272.png)

![image-20251127143307655](Correction E06 - Atelier AD.images/image-20251127143307655.png)

![image-20251127143323757](Correction E06 - Atelier AD.images/image-20251127143323757.png)

GPO ordinateurs pour les promos

![image-20251127143801994](Correction E06 - Atelier AD.images/image-20251127143801994.png)

Cela ne fonctionnera pas car dans promo il n 'ya pas d'ordinateur, il faut l'ajouter ou alors dans la gpo dans le domaine (ce n'est pas conseillé).

Donc la GPO à faire côté Utilisateur :

![image-20251127144536553](Correction E06 - Atelier AD.images/image-20251127144536553.png)

publié pour copier sur le post, attribués il l'installe et avancé je modifie certaine chose.

![image-20251127144813380](Correction E06 - Atelier AD.images/image-20251127144813380.png)

Faire un gpupdate /force

![image-20251127145141206](Correction E06 - Atelier AD.images/image-20251127145141206.png)

![image-20251127150520222](Correction E06 - Atelier AD.images/image-20251127150520222.png)

Profils Itinérants : un utilisateur qui n'a pas de poste défini, qui voyage entre des postes avec les dossiers de son profil et ses paramètres (dans un serveur).

![image-20251127150845864](Correction E06 - Atelier AD.images/image-20251127150845864.png)

Créer un partage :

![image-20251127151045013](Correction E06 - Atelier AD.images/image-20251127151045013.png)

Ajouter les droits lecture/écriture pour utilisateurs

![image-20251127151336511](Correction E06 - Atelier AD.images/image-20251127151336511.png)

Ensuite dans Profil de l'utilisateur :

![image-20251127151650834](Correction E06 - Atelier AD.images/image-20251127151650834.png)

Mettre le %username% la variable qui va utiliser le nom automatiquement \\ws2025\Profils$\%username%.

Profil créé accessible que par l'utilisateur qui a ouvert la cession et qui est dans le partage profil.

![image-20251127152019769](Correction E06 - Atelier AD.images/image-20251127152019769.png)

VSCODE / déployer par gpo https://github.com/letsdoautomation/group-policy/tree/main/Deploy%20Visual%20Studio%20Code

![image-20251127154135143](Correction E06 - Atelier AD.images/image-20251127154135143.png)



![image-20251127154232425](Correction E06 - Atelier AD.images/image-20251127154232425.png)

![image-20251127154300717](Correction E06 - Atelier AD.images/image-20251127154300717.png)