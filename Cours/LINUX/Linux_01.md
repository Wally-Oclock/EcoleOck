### Linux S04

![](Linux_01.images/linux.jpg)


​					**Au programme**

- un peu d'histoire

- les distributions Linux

- notions de base : ligne de commande, système de fichiers, etc.

- composants d'un système GNU/Linux

- sécurité

- gestion des périphériques

- concepts avancés

  Un système d'exploitation (Operating System en anglais, souvent abbrégé OS) est, en quelque sorte, le logiciel "principal" 'un
  ordinateur.
  N'importe quel ordinateur a besoin d'un OS pour fonctionner, que cet ordinateur soit un serveur, un fixe ou portable, et même un ordinateur spécialisé embarqué dans une machine.

  Le système d'exploitation gère les ressources matérielles & les
  périphériques de l'ordinateur.
  Ces ressources matérielles sont mises à disposition aux logiciels
  installés sur l'ordinateur par l'utilisateur.

![image-20251210092643671](Linux_01.images/image-20251210091929202.png)

![image-20251210093200082](Linux_01.images/image-20251210093200082.png)

![image-20251210094028058](Linux_01.images/image-20251210094028058.png)

![image-20251210095224650](Linux_01.images/image-20251210095224650.png)

![image-20251210101228497](Linux_01.images/image-20251210101228497.png)

En Septembre 1983, rms annonce qu'il commence à travailler sur un système d'exploitation compatible avec Unix, très populaire à l'époque mais qui avait l'inconvénient d'être propriétaire.
***On dit d'un logiciel qu'il est "propriétaire" (proprietary en anglais) quand son contrat de licence stipule que seul l'auteur du logiciel a le droit d'y apporter des modifications et de le distribuer.*** 

La "compatibilité" avec Unix était nécessaire pour que les utilisateurs de ce dernier puissent facilement basculer sur le nouveau système développé par Richard Stallman.

![image-20251210102338439](Linux_01.images/image-20251210102338439.png)

![image-20251210102519514](Linux_01.images/image-20251210102519514.png)

Le message posté par Linus sur le groupe Usenet comp.os.minix, le 25 août 1991 (lien archive)

![image-20251210104359588](Linux_01.images/image-20251210104359588.png)

Réponse du prof :

![image-20251210105212419](Linux_01.images/image-20251210105212419.png)

![image-20251210132941157](Linux_01.images/image-20251210132941157.png)

![image-20251210133047453](Linux_01.images/image-20251210133047453.png)

IHM : CLI vs. GUI
Avant l'apogée des interfaces graphiques (GUI - Graphical User Interface) avec l'arrivée de la souris, l'interface homme-machine
(IHM) d'un système informatique était la ligne de commande (CLI -Commande Line Interface).

Sur Windows et MacOS, la CLI est encore présente, mais n'est généralement pas ou peu utilisée par la plupart des utilisateurs.
Sur GNU/Linux, ce n'est pas le cas ! On peut parfois s'en passer dans certains environnements de bureau, mais ce n'est pas tout le temps judicieux : la CLI est souvent plus efficace qu'une interface graphique, pas besoin de chercher où cliquer parmi des dizaines de menus et boutons !

La CLI impose par contre de lire la documentation (RTFM !), ce qui n'est pas forcément le cas pour les GUI.
Une interface graphique est plus intuitive, mais pas nécessairement plus simple que copier/coller une ligne de commande.

![image-20251210133615808](Linux_01.images/image-20251210133615808.png)

~ tilde

commands : pwd = où je suis

**Commandes usuelles**
Voici quelques commandes fréquemment utilisées (page 1/2) :
• Is (LiSt files) : liste les fichiers et dossiers présents dans un dossier
• pwd (Print Workin Directory) : affiche le chemin absolu du dossier courant
• cd (Change Directory) : changer le dossier courant
• mv (MoVe) : déplacer un ou plusieurs fichiers/dossiers
• rm (ReMove) : supprimer un ou plusieurs fichiers
• rmdir (ReMove DIRectory) : supprimer un ou plusieurs dossiers
• mkdir (MaKe DIRectory) : créer un dossier
• touch : créer un fichier
• sudo (Super user DO) : lancer une commande en tant que super utilisateur (root)
• man (read MANual) : affiche la documentation (appelée manpage) d'une commande

clear = nettoyer le prompt (ctr+l)

• cat : afficher le contenu d'un fichier dans la sortie standard

• less : lire un fichier page par page (alternative : mo re)
• head : afficher la "tête" d'un fichier (les premières lignes)
• tail : afficher la "queue" d'un fichier (les dernières lignes)
• In (LiNk) : créer un lien vers un fichier
• find : rechercher un ou plusieurs fichiers/dossiers (alternative : locate)
• grep (Global Regular Expression Print) : recherche une chaîne de caractères dans des fichiers ou depuis l'entrée standard, souvent utilisée pour "filter" la sortie d'une autre commande 

• shutdown : éteindre l'ordinateur

• reboot : redémarrer l'ordinateur
• df (Disk Free) : afficher l'espace disque libre/utilisé free : affiche la mémoire vive (RAM) libre/utilisée
• uptime : affiche la durée de fonctionnement de la machine (depuis le boot) 
• uname (Unix NAME) : affiche des infos sur le système
file : permet d'identifier un fichier à partir de son type MIME

![image-20251210135554292](Linux_01.images/image-20251210135554292.png)

![](Linux_01.images/Un développeur paniq.png)

![image-20251210135624570](Linux_01.images/image-20251210135624570.png)

![image-20251210140613786](Linux_01.images/image-20251210140613786.png)

Les arguments sont renseignés directement après la commande, avant d'appuyer sur entrée pour la lancer. La commande et ses
différents arguments sont séparés par des espaces.
Pour connaître les arguments disponibles pour une commande, pas le choix, il faut lire son manuel (ou une doc en ligne, peu importe).

![image-20251210141536018](Linux_01.images/image-20251210141536018.png)

![image-20251210142120780](Linux_01.images/image-20251210142120780.png)

Quelques exemples :
lister uniquement les fichiers avec l'extension . txt dans un dossier :
Is  * . txt  /chemin/vers/dossier
• pour lister les fichiers dans le dossier parent : ls ../
• pour lister les fichiers avec l'extension . txt ou .docx : Is {`*.txt,*.docx`}

![image-20251210142532018](Linux_01.images/image-20251210142532018.png)

**Système de fichiers**

![image-20251210142958085](Linux_01.images/image-20251210142958085.png)

![image-20251210143205383](Linux_01.images/image-20251210143205383.png)

**Chemin relatif ou absolu**

Quand on manipule des fichiers dans l'arborescence d'un système d'exploitation (GNU/Linux ou autre !), on peut cibler un fichier de deux façons différentes :

. par son chemin absolu : c'est le chemin vers le fichier depuis la racine du disque.
. par un chemin relatif : c'est un chemin vers le fichier qui est relatif au dossier courant, dans lequel on se trouve actuellement. 💡

![image-20251210144801034](Linux_01.images/image-20251210144801034.png)

![image-20251210145023004](Linux_01.images/image-20251210145023004.png)

### Entrées, sorties, redirections

![image-20251210145555616](Linux_01.images/image-20251210145555616.png)

![image-20251210145607807](Linux_01.images/image-20251210145607807.png)

![](Linux_01.images/2025-12-10_145655.png)

![image-20251210145859450](Linux_01.images/image-20251210145859450.png)

![image-20251210145946037](Linux_01.images/image-20251210145946037.png)

![image-20251210150134487](Linux_01.images/image-20251210150134487.png)

![image-20251210150313715](Linux_01.images/image-20251210150313715.png)

![image-20251210150427145](Linux_01.images/image-20251210150427145.png)

![image-20251210151517553](Linux_01.images/image-20251210151517553.png)

**Manipulation de fichiers texte**
Créer des fichiers, les copier, les déplacer, les supprimer, c'est bien ! Pouvoir écrire dedans, c'est mieux.

![image-20251210151620996](Linux_01.images/image-20251210151620996.png)

![image-20251210151703363](Linux_01.images/image-20251210151703363.png)

![image-20251210151830309](Linux_01.images/image-20251210151830309.png)

![image-20251210152007421](Linux_01.images/image-20251210152007421.png)

![image-20251210152052234](Linux_01.images/image-20251210152052234.png)

![image-20251210152239423](Linux_01.images/image-20251210152239423.png)

![image-20251210152707016](Linux_01.images/image-20251210152707016.png)

![image-20251210152801690](Linux_01.images/image-20251210152801690.png)

![image-20251210152820744](Linux_01.images/image-20251210152820744.png)

![image-20251210153422073](Linux_01.images/image-20251210153422073.png)

![image-20251210153435813](Linux_01.images/image-20251210153435813.png)

> [!IMPORTANT]
>
> 💡**Nano**💡
> GNU Nano est un éditeur de texte créé en 1999 par Chris Allegretta.
> Il est basé sur la bibliothèque ncurses, qui permet de réaliser des pseudo-interfaces graphiques en ligne de commande.
> Cest un clone libre de l'éditeur Pico, dont il s'efforce de reproduire les fonctionnalités et la simplicité. Il est fréquemment utilisé par les débutants (et pas que !) et présent par défaut sur de nombreuses distributions GNU/Linux pour sa simplicité d'utilisation. Il est beaucoup plus limité que Vim ou Emacs.

