sudo su - ( pour passer root )
cd /var/lib/vz/images/9000 ( aller dans le bon dossier )
qemu-img convert -f qcow2 -O qcow2 -o preallocation=off vm-9000-disk-1.qcow2 newdisk.qcow2
rm vm-9000-disk-1.qcow2 ( supprimer )
mv newdisk.qcow2 vm-9000-disk-1.qcow2 ( renommer )
a adapter avec ID de sa VM et les bon disques

![image-20251205092000759](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251205092000759.png)

![image-20251205092006197](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251205092006197.png)

![image-20251205092012220](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251205092012220.png)

![image-20251205092017654](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251205092017654.png)

![image-20251205092053610](C:\Users\walim\AppData\Roaming\Typora\typora-user-images\image-20251205092053610.png)