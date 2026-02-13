# HCA LAB

## Interstitial WAN - AS 64512

CAMPUS A-R1: 169.254.10.0/31 <-> WAN:169.254.10.1/31

CAMPUS A-R2: 169.254.10.2/31 <-> WAN:169.254.10.3/31

CAMPUS B-R1: 169.254.20.0/31 <-> WAN:169.254.20.1/31

CAMPUS B-R2: 169.254.20.2j/31 <-> WAN:169.254.20.3/31

CAMPUS C-R1: 169.254.30.0/31 <-> WAN:169.254.30.1/31

CAMPUS C-R2: 169.254.30.2/31 <-> WAN:169.254.30.3/31

CAMPUS D-R1: 169.254.40.0/31 <-> WAN:169.254.40.1/31

CAMPUS D-R2: 169.254.40.2/31 <-> WAN:169.254.40.3/31

## Campus A - AS 65100 - 65199

IP Range: 10.10.0.0/16

Underlay: 172.16.0.0/24

```eos
  interface Vlan 10
     description MGMT
     ip address-virtual 10.10.10.1/24
  interface Vlan 20
     description USER
     ip address-virtual 10.10.20.1/24
  interface Vlan 30
     description VOICE
     ip address-virtual 10.10.30.1/24
  interface Vlan 40
     description PACS
     ip address-virtual 10.10.40.1/24
  interface Lo0
     ip address 172.16.10.1/24
  interface Lo1
     ip address 172.16.11.1/24
```

## Campus B AS 65200 - 65299

IP Range: 10.20.0.0/16

Underlay: 172.16.0.0/24

```  interface Vlan 10
     description MGMT
     ip address-virtual 10.20.10.1/24
  interface Vlan 20
     description USER
     ip address-virtual 10.20.20.1/24
  interface Vlan 30
     description VOICE
     ip address-virtual 10.20.30.1/24
  interface Vlan 40
     description PACS
     ip address-virtual 10.20.40.1/24
  interface Lo0
     ip address 172.16.20.1/24
  interface Lo1
     ip address 172.16.21.1/24
```

## Campus C AS 65300 - 65399

IP Range: 10.30.0.0/16

Underlay: 172.16.0.0/24

```  interface Vlan 10
     description MGMT
     ip address-virtual 10.30.10.1/24
  interface Vlan 20
     description USER
     ip address-virtual 10.30.20.1/24
  interface Vlan 30
     description VOICE
     ip address-virtual 10.30.30.1/24
  interface Vlan 40
     description PACS
     ip address-virtual 10.30.40.1/24
  interface Lo0
     ip address 172.16.30.1/24
  interface Lo1
     ip address 172.16.31.1/24
```

## Campus D AS 65400 - 65499

IP Range: 10.40.0.0/16

Underlay: 172.16.0.0/24

```  interface Vlan 10
     description MGMT
     ip address-virtual 10.40.10.1/24
  interface Vlan 20
     description USER
     ip address-virtual 10.40.20.1/24
  interface Vlan 30
     description VOICE
     ip address-virtual 10.40.30.1/24
  interface Vlan 40
     description PACS
     ip address-virtual 10.40.40.1/24
  interface Lo0
     ip address 172.16.40.1/24
  interface Lo1
     ip address 172.16.41.1/24
```
