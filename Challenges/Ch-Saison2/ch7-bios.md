## ⌨️ Challenge

- Accédez au BIOS de votre ordinateur, et explorez les différentes pages, sections et réglages proposés !
  - ⚠️ Ne modifiez rien, vous risqueriez d’empêcher votre ordinateur de démarrer.
  - Prenez des photos des pages ou des réglages que vous ne comprenez/connaissez pas.
  - Pour ceux qui sont sur Mac, pas de BIOS dispo ! Vous pouvez explorer ce [simulateur en ligne ](https://l.oclock.io/andromede-technicien-support-it-854ada6c557d64d4c9d71322d397f5bf). ou [celui-ci](https://l.oclock.io/andromede-technicien-support-it-2d06d5739f2508d8eec5b6db68bc43d4) ou [encore lui](https://l.oclock.io/andromede-technicien-support-it-dcfb4ea81259b23bbf3a6e14b722ee4b)
- Sauvegardez les données d’une clé USB, puis tentez de :
  - convertir sa table de partitions de MBR à GPT (ou l’inverse) à l’aide de l’utilitaire `DiskPart` (depuis une VM Windows, si vous êtes sous MacOS)
  - créer plusieurs partitions sur cette clé et tester de les formater avec différents systèmes de fichiers : NTFS, FAT32 et ExFAT
  - testez la compatibilité avec les différents systèmes d’exploitation (en connectant la clé USB sur des VMs VirtualBox)

💡 Vous devrez potentiellement réussir à connecter une clé USB sur une VM VirtualBox. À vous de trouver comment faire !

## **Accès au bios du laptop linux**💻

Computrace Absolute : l’incroyable mouchard planqué dans le BIOS de millions de PC : <img src="ch7-bios.images/dog.webp" alt="dog" style="zoom:25%;" /> 

![20251027_144617](ch7-bios.images/20251027_144617.jpg)

 

![20251027_144126](ch7-bios.images/20251027_144126.jpg)

Bios cpu :

![20251027_144418](ch7-bios.images/20251027_144418.jpg)

![20251027_144301](ch7-bios.images/20251027_144301.jpg)

**Ajour clef usb sur VM**💻

![usb1](ch7-bios.images/usb1.jpg)

**convertir sa table de partitions de MBR à GPT et formatage DISKPART**

![usb-MBRversGPTETFORMATF32](ch7-bios.images/usb-MBRversGPTETFORMATF32.jpg)


**NTFS-ok-Win11**

![NTFS-ok-Win11](ch7-bios.images/NTFS-ok-Win11.jpg)

