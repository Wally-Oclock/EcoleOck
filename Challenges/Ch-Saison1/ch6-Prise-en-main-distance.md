# Prise-en-main-distance
MemTest86 et Prise en main a distance
Essayez l’outil MemTest86 sur votre PC !

Il vous faudra pour cela une clé USB, sauvegardez tout ce que vous avez dessus avant de suivre les instructions ci-dessous ! ⚠️
1 : Téléchargez MemTest86 Free depuis le site officiel :
Dans une première étape avant test de l'application, il fallait télécharger MemTest86 depuis le site officiel suivant les recommandations de sécurité. Il s'agit de la version 11.5 Build 1000 depuis le site PassMARK softwareL'installation
![memtest-downld](https://github.com/user-attachments/assets/8349fbd5-f826-4160-96c0-08636bd75de9)
Dans un second temps, j'ai décompressé le contenu dans un dossier avant d'exécuter l'imageUSB sur le programme Rufus. Pour rappel, Rufus est un utilitaire permettant de formater et de créer des média USB démarrables, tels que clés USB, etc.
![rufus](https://github.com/user-attachments/assets/dd47b555-08e2-4b43-820b-f1de7f5e42b8)
![rufus2](https://github.com/user-attachments/assets/37b430bf-8e55-4e3d-afbe-0dace10ecd29)

Une fois la clef USB est prête, l'étape suivante consiste à demarrer le pc Laptop Lenovo sur la clef préparée. Pour cela, j'ai activé cette tâche en pressant au demarrage la touche SUPPR et j'aidonné la Boot priority à la clef usb.
Redémarrez votre PC et bootez sur MemTest !
*Le BIOS suit, en fait, un ordre de prédéfinis, c’est-à-dire une séquence de démarrage.
En effet, il teste les périphériques dans l’ordre : DVD-Rom, Disque dur, Réseau, Clé USB
On appelle cela le « Boot priority » pour priorité de démarrage du PC.*

https://github.com/user-attachments/assets/5a44cc6c-a6fa-4cf0-9c8e-1bad7861bc34

Lancez un test complet de votre RAM.
![20251022_174421](https://github.com/user-attachments/assets/885930ab-df74-4914-a085-2e6b92827753)
#🏆 Challenge Bonus#
Rendez-vous avec des outils de prise en main à distance, que ce soit AnyDesk, TeamViewer, ou même les outils natifs de votre système d’exploitation.
L’objectif est simplement d’explorer leurs possibilités et de tester par vous-même différents outils.
Les différentes étapes pour la configuration de l'accès à distance avec Teamviewer :
J'ai téléchargé et installé le logiciel sur les 2 machines hôte Admin la mienne et celle client sur un laptop (en QuickSupport).
J'ai ouvert la session Teamviewer sur la machine Admin et je l'ai nommé ''Test-Oclolck''J'ai obtenu un N° de cession que j'ai donné au client afin d'établir la connexion à distance.
![TViewer-testoclock](https://github.com/user-attachments/assets/36bc0839-69be-4065-917c-ab922a994221)

Le client fait la même chose de son côté et valide la connexion. Pour résumer, j'ai utilisé l’identifiant et le mot de passe pour se connecter à mon appareil à distance. J'ai donné le code attribué au client
Le client a partagé avec moi le contrôle de son appareil en cliquant sur le bouton “Autoriser” sur l’écran.
PC hôte Admin
![TViewer-testoclock-ok](https://github.com/user-attachments/assets/c814f387-f983-4dc5-982f-f9c97e71d9bf)
Le laptop client pris en main à distance
![20251022_184944](https://github.com/user-attachments/assets/04180540-805d-47fc-9854-9d4b34fa498d)
![20251022_184823](https://github.com/user-attachments/assets/94137aed-a3ca-4704-b22b-d6e92dfb90d7)
![20251022_184645](https://github.com/user-attachments/assets/854a6afa-b111-440e-9dcb-b1ce7c55a014)
![TViewer-testoclock-ok](https://github.com/user-attachments/assets/043ef3f6-8b8d-421e-a27c-f8974a9ca941)
#🏆 Challenge Bonus plus Bureau à distance sur VM#
iL FAUT installer le pack extension de Virtualbox et ouvrir l'affichage du panneau de configuration de la VM afin d'activer le serveur.
![bad-vm1](https://github.com/user-attachments/assets/70f34edf-5dc5-4fff-94e0-6b563d7f8306)
Sinon en installant Teamviewer sur la vm
![TViewer-vm](https://github.com/user-attachments/assets/0f66b6cc-4451-4462-9e82-227aa7ef67cd)
![TViewer-hote](https://github.com/user-attachments/assets/47b6cab6-b471-42e7-ad64-decb5421f07e)


