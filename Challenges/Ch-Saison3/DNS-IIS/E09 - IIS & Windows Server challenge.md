# E09 - IIS & Windows Server Backup

## ⌨️ Challenge

- Identifier l’utilisateur supprimé dans l’Active Directory.

  > > > Suppression de l'utilisateur Christophe SEIGNANT

- Ouvrir Windows Server Backup et localiser une sauvegarde contenant l’utilisateur.

  - > > > Restauration du dossier NTDS contenant les objets dont l'user supprimé

    ![image-20251201162849131](E09 - IIS & Windows Server challenge.images/image-20251201162849131.png)

    ![image-20251201163716463](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201163716463.png)

- Effectuer une restauration de l’état du système.

  ![image-20251201163030029](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201163030029.png)

  ![image-20251201163145972](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201163145972.png)

  Les fichiers à restaurer :

  ![image-20251201163228476](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201163228476.png)

  Solution : Redémarrer en “Mode Restauration des services d’annuaire” (Directory Services Restore Mode – DSRM)

  Avec la commande : bcdedit /set safeboot dsrepair

  Copier/coller les fichiers sauvegardés dans NTDS et écraser les anciens.

  En CMD : bcdedit /deletevalue safeboot pour sortir du mode safe.

  ![image-20251201164516230](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201164516230.png)

- Vérifier que l’utilisateur apparaît à nouveau dans l’AD après le redémarrage.

  ![image-20251201164553641](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201164553641.png)

  Christophe SEIGNANT est de retour.

  ![image-20251201164814378](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201164814378.png)

- Tester la connexion avec le compte restauré.

  

![image-20251201164835957](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251201164835957.png)