### VDI

## **L’essentiel**

La Virtual Desktop Infrastructure (VDI) est une technologie qui centralise les bureaux virtuels dans un data center, permettant aux utilisateurs d’y accéder depuis n’importe quel appareil connecté, ce qui améliore considérablement la sécurité, la gestion des coûts et la flexibilité des systèmes informatiques.

Les clients légers, servant de terminaux pour ces bureaux virtuels, réduisent les coûts matériels et énergétiques, simplifient la maintenance et renforcent la sécurité en éliminant le besoin de capacités de traitement locales. La configuration d’un client léger implique son branchement et sa connexion au réseau, l’accès à son interface pour régler les paramètres de réseau et d’affichage, ainsi que la configuration de la connexion au serveur VDI, incluant l’adresse du serveur, le protocole de connexion et les identifiants d’accès.

Il est crucial de tester la connexion pour s’assurer de la qualité d’affichage, de la réactivité des applications et de la stabilité de la connexion. Pour maintenir un haut niveau de sécurité, il est recommandé d’utiliser des méthodes d’authentification fortes et de réaliser des mises à jour régulières, tout en évitant les erreurs communes liées à la sécurité du réseau et à l’estimation des besoins en bande passante.

En résumé, la VDI et les clients légers offrent une approche optimisée pour la gestion des environnements de travail virtuels, garantissant sécurité, efficacité et flexibilité.

On parle du principe du Mastering, on crée une VM master avec ses applications joignable pour un utilisateur à distance sur un serveur

A partir de l'hyper V une vm crée avec win10 (master)

GENERALIZATION :  à partir d'une vm créée, les réglages seront uniques donc à nettoyer l'utilisateur : on va sur la vm win10 et gestion de l'ordinateur

![image-20251205102013059](VDI.images/image-20251205102013059.png)

J'active le compte administrateur et je change de mdp

![image-20251205102538009](VDI.images/image-20251205102538009.png)

Se déconnecter pour se reconnecter en tant qu'administrateur

![image-20251205102722772](VDI.images/image-20251205102722772.png)

résumé : 

1- clique droit menu démarrer , gestion de l’ordinateur

2- utilisateurs , et réactivé le compte administrateur

8. redefinir le mdp du compte administrateur
9. démarrer compte utilisateur et se deconnecter
10. se connecter sur administrateur

![image-20251205103649159](VDI.images/image-20251205103649159.png)

C:\Windows\System32\sysprep

![image-20251205103830966](VDI.images/image-20251205103830966.png)

double clique

![image-20251205103912771](VDI.images/image-20251205103912771.png)

Avant de pouvoir déployer une image Windows sur de nouveaux PC, vous devez d’abord généraliser cette image. La généralisation de l’image supprime les informations spécifiques à l’ordinateur, telles que les pilotes installés et l’identificateur de sécurité (SID) de l’ordinateur. Vous pouvez utiliser [Sysprep](https://learn.microsoft.com/fr-fr/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview?view=windows-11) seul ou Sysprep avec un fichier de réponses [sans assistance](https://learn.microsoft.com/fr-fr/windows-hardware/customize/desktop/unattend/) pour généraliser votre image et la préparer au déploiement.

Mode audit pour rentrer dans le sysprep pour le préparer ou OOBE

![image-20251205104627105](VDI.images/image-20251205104627105.png)

![image-20251205104705949](VDI.images/image-20251205104705949.png)

![image-20251205132221474](VDI.images/image-20251205132221474.png)![image-20251205132234940](VDI.images/image-20251205132234940.png)![image-20251205132305182](VDI.images/image-20251205132305182.png)

![image-20251205132335975](VDI.images/image-20251205132335975.png)

![image-20251205132520064](VDI.images/image-20251205132520064.png)

![image-20251205132552666](VDI.images/image-20251205132552666.png)

![image-20251205132706344](VDI.images/image-20251205132706344.png)

![image-20251205132904338](VDI.images/image-20251205132904338.png)

![image-20251205132955181](VDI.images/image-20251205132955181.png)

si Echec :

![image-20251205133933525](VDI.images/image-20251205133933525.png)

