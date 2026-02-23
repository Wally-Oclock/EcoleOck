**Openstack ping ip flottante issue :**



Le lien physique (OVS Bridge)

Puisque le réseau est de type Flat sur le réseau physique public, OpenStack s'attend à ce qu'une carte réseau réelle de votre serveur soit branchée sur ce segment.



Le problème : Si l'interface physique (ex: eth1 ou enp3s0) n'est pas correctement liée au pont virtuel (souvent br-ex), le trafic meurt au bord du serveur.



Vérification (sur le serveur OpenStack) :

sudo ovs-vsctl show

S'il manque le ''pont'' vers le monde réel, le Bridge br-ex qui relie le réseau interne br-int est vide de toutes interface physique.(Dans une configuration OpenStack fonctionnelle, le pont br-ex (ou celui lié à votre réseau public) doit obligatoirement contenir une carte réseau physique de votre serveur pour que les paquets puissent sortir vers votre PC. Pour l'instant, votre routeur virtuel parle dans un tuyau qui s'arrête à l'intérieur de la mémoire du serveur.)



**Solution : 1- Activer le pont externe**

**Même si l'IP est configurée, le pont est administrativement éteint. Il faut l'allumer :**



**Bash**

**sudo ip link set br-ex up**

**2- Identifiez votre interface physique libre avec ip a**

**3- Ajouter le port : sudo ovs-vsctl add-port br-ex ''ens18'' votre interface sans ''**

>> Le trafic SSH devra alors passer par br-ex

le pont br-ex est UP, on peut ping la Gateway du routeur 172.24.4.23 ou autre.

***Le revers de la médaille classique quand on manipule les interfaces réseau sur le serveur hôte : en activant ou en déplaçant des interfaces pour OpenStack, vous avez probablement "cassé" la route vers l'adresse IP de management sur votre interface physique***.

4- La solution pour tout retrouver :

Commandes à faire en console locale proxmox :



Bash

\# 1. Enlever l'IP de l'interface physique

sudo ip addr del 10.0.0.100/16 dev ens18



\# 2. S'assurer que ens18 est bien dans le pont

sudo ovs-vsctl add-port br-ex ens18 2>/dev/null



\# 3. Mettre l'IP de management sur le pont lui-même

sudo ip addr add 10.0.0.100/16 dev br-ex

sudo ip link set br-ex up



**Attention au Routage**

Vérifiez que votre "Default Gateway" n'a pas sauté. Si vous ne pouvez plus sortir sur Internet depuis le serveur :

sudo ip route add default via 10.0.0.1

