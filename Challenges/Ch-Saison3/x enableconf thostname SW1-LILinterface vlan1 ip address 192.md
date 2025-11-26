```
enable
conf t
hostname SW1-LIL
interface vlan1 
ip address 192.168.1.254
no shutdown
end
copy run sta
```

```
enable
conf t 
hostname R1-LIL
interface Gig 0/0
ip address 192.168.1.1
no shutdown
interface Gig 0/3/0
ip address 84.17.59.34
no shutdown
end
copy run sta
```

```
conf t
interface gig 0/3/0
ip nat outside 
exit
interface gig 0/0
ip nat inside
end
copy run sta
```

```
conf t
access-list 1 permit 172.16.0.0 0.0.255.255
ip nat inside source list 1 interface gigabitEthernet 0/3/0 overload
```

Pour une liaison : Home Two => Internet Home One => Internet Une route par default à été créer

```
ip route 0.0.0.0 0.0.0.0 84.17.59.34
```

Pour une communication avec les machine des différent lan, il faut faire une redirection de ports .

Mise en place d'un serveur sur LAN 2 172.16.0.0

Redirection du port 80 du serveur vers notre ip public

```
ip nat inside source static tcp 172.16.0.51 80 84.17.59.34 80
```