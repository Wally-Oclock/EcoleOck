Correction

suppression des sites et des dossiers de partage

![image-20251202091737653](Correction-Sauvegared.images/image-20251202091737653.png)

Plus de partage

![image-20251202091914904](Correction-Sauvegared.images/image-20251202091914904.png)

On restaure l'ad et ensuite les partages>>>on passe en mode sans échec car les services tournent toujours. On doit passer par le DSRM.

On passe par Msconfig

![image-20251202092140139](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202092140139.png)

![image-20251202092225822](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202092225822.png)

et je redémarre le pc et dans ce mode je ne peux me connecter qu'en compte administrateur local. Erreur normal car le domaine est coupé.

![image-20251202092325573](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202092325573.png)

Administrateur et mot de passe DSRM ( de récupération de l'AD)

![image-20251202092504126](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202092504126.png)

A ce niveau là pas de domaine, on ne peut rien faire sur l'AD.

Je restaure ce qui intéresse :

![image-20251202093349901](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202093349901.png)

![image-20251202093508122](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202093508122.png)

Soit restaurer le dossier NTDS ou Volume, applications ou état du système.

Si on fait application on aura :

![image-20251202093719254](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202093719254.png)

Sélectionner AD ET restaurer à un autre emplacement (je serai forcément sur le pc local administrateur) : Résultats de la restore :s

![image-20251202093921027](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202093921027.png)

Copier/coller les fichiers dans le dossier NTDS

![image-20251202094243003](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202094243003.png)

En passant par les fichiers et dossiers, on restaure aussi les droits utilisateurs:

![image-20251202094358838](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202094358838.png)

![image-20251202094511067](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202094511067.png)

Et l'emplacement :

J'écrase dans notre cas car il n'y avait pas bcp de modifs depuis la sauvegarde sinon créer des copies :

![image-20251202094713671](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202094713671.png)

les fichiers restaurés :

![image-20251202094838877](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202094838877.png)

Récupérer l'état du système (attention si le serveur de réplication a aussi hériter l'erreur il faut activer l'autorité des fichiers ATTENTION) vaut mieux faire une restauration sur chaque domaine.

![image-20251202094937795](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202094937795.png)

![image-20251202095227922](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202095227922.png)

![image-20251202095555748](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251202095555748.png)