# campus-c-leaf2a

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [IP Name Servers](#ip-name-servers)
  - [Clock Settings](#clock-settings)
  - [NTP](#ntp)
  - [IP Client Source Interfaces](#ip-client-source-interfaces)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [Enable Password](#enable-password)
- [Monitoring](#monitoring)
  - [TerminAttr Daemon](#terminattr-daemon)
  - [SNMP](#snmp)
- [MLAG](#mlag)
  - [MLAG Summary](#mlag-summary)
  - [MLAG Device Configuration](#mlag-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Device Configuration](#internal-vlan-allocation-policy-device-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [Interfaces](#interfaces)
  - [Interface Defaults](#interface-defaults)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
  - [VXLAN Interface](#vxlan-interface)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [Virtual Source NAT](#virtual-source-nat)
  - [Virtual Source NAT Summary](#virtual-source-nat-summary)
  - [Virtual Source NAT Configuration](#virtual-source-nat-configuration)
- [EOS CLI Device Configuration](#eos-cli-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | OOB_MANAGEMENT | oob | default | 192.168.0.55/24 | 192.168.0.1 |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management1 | OOB_MANAGEMENT | oob | default | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management1
   description OOB_MANAGEMENT
   no shutdown
   ip address 192.168.0.55/24
```

### IP Name Servers

#### IP Name Servers Summary

| Name Server | VRF | Priority |
| ----------- | --- | -------- |
| 169.254.169.254 | default | - |

#### IP Name Servers Device Configuration

```eos
ip name-server vrf default 169.254.169.254
```

### Clock Settings

#### Clock Timezone Settings

Clock Timezone is set to **America/Chicago**.

#### Clock Device Configuration

```eos
!
clock timezone America/Chicago
```

### NTP

#### NTP Summary

##### NTP Local Interface

| Interface | VRF |
| --------- | --- |
| Management1 | default |

##### NTP Servers

| Server | VRF | Preferred | Burst | iBurst | Version | Min Poll | Max Poll | Local-interface | Key |
| ------ | --- | --------- | ----- | ------ | ------- | -------- | -------- | --------------- | --- |
| 1.pool.ntp.org | default | - | - | - | - | - | - | - | - |

#### NTP Device Configuration

```eos
!
ntp local-interface Management1
ntp server 1.pool.ntp.org
```

### IP Client Source Interfaces

| IP Client | VRF | Source Interface Name |
| --------- | --- | --------------------- |
| SSH | default | Loopback0 |

#### IP Client Source Interfaces Device Configuration

```eos
!
ip ssh client source-interface Loopback0
 ```

### Management API HTTP

#### Management API HTTP Summary

| HTTP | HTTPS | UNIX-Socket | Default Services |
| ---- | ----- | ----------- | ---------------- |
| False | True | - | - |

#### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| default | - | - |

#### Management API HTTP Device Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf default
      no shutdown
```

## Authentication

### Local Users

#### Local Users Summary

| User | Privilege | Role | Disabled | Shell |
| ---- | --------- | ---- | -------- | ----- |
| admin | 15 | network-admin | False | - |
| ansible | 15 | network-admin | False | - |
| cvpadmin | 15 | network-admin | False | - |
| robert | 15 | network-admin | False | - |

#### Local Users Device Configuration

```eos
!
username admin privilege 15 role network-admin secret sha512 <removed>
username ansible privilege 15 role network-admin secret sha512 <removed>
username cvpadmin privilege 15 role network-admin secret sha512 <removed>
username robert privilege 15 role network-admin nopassword
username robert ssh-key ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7U+usFHr9Xhqph3HcmaWpi/Tjl0a3aof1AQRvSXuOw redmonds@redmonds
```

### Enable Password

Enable password has been disabled

## Monitoring

### TerminAttr Daemon

#### TerminAttr Daemon Summary

| CV Compression | CloudVision Servers | VRF | Authentication | Smash Excludes | Ingest Exclude | Bypass AAA |
| -------------- | ------------------- | --- | -------------- | -------------- | -------------- | ---------- |
| gzip | 192.168.0.5:9910 | default | token,/tmp/cv-onboarding-token | ale,flexCounter,hardware,kni,pulse,strata | - | True |

#### TerminAttr Daemon Device Configuration

```eos
!
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr=192.168.0.5:9910 -cvauth=token,/tmp/cv-onboarding-token -cvvrf=default -disableaaa -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -taillogs
   no shutdown
```

### SNMP

#### SNMP Configuration Summary

| Contact | Location | SNMP Traps | State |
| ------- | -------- | ---------- | ----- |
| - | HCA CAMPUS campus-c-leaf2a | All | Disabled |

#### SNMP Device Configuration

```eos
!
snmp-server location HCA CAMPUS campus-c-leaf2a
```

## MLAG

### MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| campus-c-leaf2 | Vlan4094 | 10.255.255.69 | Port-Channel11 |

Dual primary detection is enabled. The detection delay is 5 seconds.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id campus-c-leaf2
   local-interface Vlan4094
   peer-address 10.255.255.69
   peer-address heartbeat 192.168.0.56
   peer-link Port-Channel11
   dual-primary detection delay 5 action errdisable all-interfaces
   reload-delay mlag 300
   reload-delay non-mlag 330
```

## Spanning Tree

### Spanning Tree Summary

STP mode: **mstp**

#### MSTP Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 0 | 16384 |

#### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4093-4094**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
no spanning-tree vlan-id 4093-4094
spanning-tree mst 0 priority 16384
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

### Internal VLAN Allocation Policy Device Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## VLANs

### VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 110 | Blue_110 | - |
| 111 | Blue_111 | - |
| 112 | Blue_112 | - |
| 113 | Blue_113 | - |
| 120 | Red_120 | - |
| 121 | WEBZone_121 | - |
| 130 | Green_130 | - |
| 131 | Green_131 | - |
| 3009 | MLAG_L3_VRF_Blue | MLAG |
| 3010 | MLAG_L3_VRF_Red | MLAG |
| 3011 | MLAG_L3_VRF_Green | MLAG |
| 4093 | MLAG_L3 | MLAG |
| 4094 | MLAG | MLAG |

### VLANs Device Configuration

```eos
!
vlan 110
   name Blue_110
!
vlan 111
   name Blue_111
!
vlan 112
   name Blue_112
!
vlan 113
   name Blue_113
!
vlan 120
   name Red_120
!
vlan 121
   name WEBZone_121
!
vlan 130
   name Green_130
!
vlan 131
   name Green_131
!
vlan 3009
   name MLAG_L3_VRF_Blue
   trunk group MLAG
!
vlan 3010
   name MLAG_L3_VRF_Red
   trunk group MLAG
!
vlan 3011
   name MLAG_L3_VRF_Green
   trunk group MLAG
!
vlan 4093
   name MLAG_L3
   trunk group MLAG
!
vlan 4094
   name MLAG
   trunk group MLAG
```

## Interfaces

### Interface Defaults

#### Interface Defaults Summary

- Default Ethernet Interface Shutdown: True

#### Interface Defaults Device Configuration

```eos
!
interface defaults
   ethernet
      shutdown
```

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet11 | MLAG_campus-c-leaf2b_Ethernet11 | *trunk | *2-4094 | *- | *MLAG | 11 |
| Ethernet12 | MLAG_campus-c-leaf2b_Ethernet12 | *trunk | *2-4094 | *- | *MLAG | 11 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_campus-c-spine1_Ethernet7 | - | 172.31.254.137/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_campus-c-spine2_Ethernet7 | - | 172.31.254.139/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_campus-c-spine1_Ethernet7
   no shutdown
   mtu 1500
   no switchport
   ip address 172.31.254.137/31
!
interface Ethernet2
   description P2P_campus-c-spine2_Ethernet7
   no shutdown
   mtu 1500
   no switchport
   ip address 172.31.254.139/31
!
interface Ethernet11
   description MLAG_campus-c-leaf2b_Ethernet11
   no shutdown
   channel-group 11 mode active
!
interface Ethernet12
   description MLAG_campus-c-leaf2b_Ethernet12
   no shutdown
   channel-group 11 mode active
!
interface Management1
   no lldp transmit
   no lldp receive
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel11 | MLAG_campus-c-leaf2b_Port-Channel11 | trunk | 2-4094 | - | MLAG | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel11
   description MLAG_campus-c-leaf2b_Port-Channel11
   no shutdown
   switchport trunk allowed vlan 2-4094
   switchport mode trunk
   switchport trunk group MLAG
   switchport
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | ROUTER_ID | default | 192.168.224.35/32 |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | 192.168.223.35/32 |
| Loopback100 | DIAG_VRF_Blue | Blue | 192.168.200.35/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | ROUTER_ID | default | - |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | - |
| Loopback100 | DIAG_VRF_Blue | Blue | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description ROUTER_ID
   no shutdown
   ip address 192.168.224.35/32
!
interface Loopback1
   description VXLAN_TUNNEL_SOURCE
   no shutdown
   ip address 192.168.223.35/32
!
interface Loopback100
   description DIAG_VRF_Blue
   no shutdown
   vrf Blue
   ip address 192.168.200.35/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan110 | Blue_110 | Blue | - | False |
| Vlan111 | Blue_111 | Blue | - | False |
| Vlan112 | Blue_112 | Blue | - | False |
| Vlan113 | Blue_113 | Blue | - | False |
| Vlan120 | Red_120 | Red | - | False |
| Vlan121 | WEBZone_121 | Red | - | False |
| Vlan130 | Green_130 | Green | - | False |
| Vlan131 | Green_131 | Green | - | False |
| Vlan3009 | MLAG_L3_VRF_Blue | Blue | 1500 | False |
| Vlan3010 | MLAG_L3_VRF_Red | Red | 1500 | False |
| Vlan3011 | MLAG_L3_VRF_Green | Green | 1500 | False |
| Vlan4093 | MLAG_L3 | default | 1500 | False |
| Vlan4094 | MLAG | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan110 |  Blue  |  -  |  192.168.210.1/24  |  -  |  -  |  -  |
| Vlan111 |  Blue  |  -  |  192.168.211.1/24  |  -  |  -  |  -  |
| Vlan112 |  Blue  |  -  |  192.168.212.1/24  |  -  |  -  |  -  |
| Vlan113 |  Blue  |  -  |  192.168.213.1/24  |  -  |  -  |  -  |
| Vlan120 |  Red  |  -  |  192.168.220.1/24  |  -  |  -  |  -  |
| Vlan121 |  Red  |  -  |  192.168.221.1/24  |  -  |  -  |  -  |
| Vlan130 |  Green  |  -  |  192.168.230.1/24  |  -  |  -  |  -  |
| Vlan131 |  Green  |  -  |  192.168.231.1/24  |  -  |  -  |  -  |
| Vlan3009 |  Blue  |  10.255.254.68/31  |  -  |  -  |  -  |  -  |
| Vlan3010 |  Red  |  10.255.254.68/31  |  -  |  -  |  -  |  -  |
| Vlan3011 |  Green  |  10.255.254.68/31  |  -  |  -  |  -  |  -  |
| Vlan4093 |  default  |  10.255.254.68/31  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  10.255.255.68/31  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan110
   description Blue_110
   no shutdown
   vrf Blue
   ip address virtual 192.168.210.1/24
!
interface Vlan111
   description Blue_111
   no shutdown
   vrf Blue
   ip address virtual 192.168.211.1/24
!
interface Vlan112
   description Blue_112
   no shutdown
   vrf Blue
   ip address virtual 192.168.212.1/24
!
interface Vlan113
   description Blue_113
   no shutdown
   vrf Blue
   ip address virtual 192.168.213.1/24
!
interface Vlan120
   description Red_120
   no shutdown
   vrf Red
   ip address virtual 192.168.220.1/24
!
interface Vlan121
   description WEBZone_121
   no shutdown
   vrf Red
   ip address virtual 192.168.221.1/24
!
interface Vlan130
   description Green_130
   no shutdown
   vrf Green
   ip address virtual 192.168.230.1/24
!
interface Vlan131
   description Green_131
   no shutdown
   vrf Green
   ip address virtual 192.168.231.1/24
!
interface Vlan3009
   description MLAG_L3_VRF_Blue
   no shutdown
   mtu 1500
   vrf Blue
   ip address 10.255.254.68/31
!
interface Vlan3010
   description MLAG_L3_VRF_Red
   no shutdown
   mtu 1500
   vrf Red
   ip address 10.255.254.68/31
!
interface Vlan3011
   description MLAG_L3_VRF_Green
   no shutdown
   mtu 1500
   vrf Green
   ip address 10.255.254.68/31
!
interface Vlan4093
   description MLAG_L3
   no shutdown
   mtu 1500
   ip address 10.255.254.68/31
!
interface Vlan4094
   description MLAG
   no shutdown
   mtu 1500
   no autostate
   ip address 10.255.255.68/31
```

### VXLAN Interface

#### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback1 |
| UDP port | 4789 |
| EVPN MLAG Shared Router MAC | mlag-system-id |

##### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 110 | 10110 | - | - |
| 111 | 50111 | - | - |
| 112 | 50112 | - | - |
| 113 | 10113 | - | - |
| 120 | 10120 | - | - |
| 121 | 10121 | - | - |
| 130 | 10130 | - | - |
| 131 | 10131 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Overlay Multicast Group to Encap Mappings |
| --- | --- | ----------------------------------------- |
| Blue | 10 | - |
| Green | 12 | - |
| Red | 11 | - |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description campus-c-leaf2a_VTEP
   vxlan source-interface Loopback1
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 110 vni 10110
   vxlan vlan 111 vni 50111
   vxlan vlan 112 vni 50112
   vxlan vlan 113 vni 10113
   vxlan vlan 120 vni 10120
   vxlan vlan 121 vni 10121
   vxlan vlan 130 vni 10130
   vxlan vlan 131 vni 10131
   vxlan vrf Blue vni 10
   vxlan vrf Green vni 12
   vxlan vrf Red vni 11
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### Virtual Router MAC Address

#### Virtual Router MAC Address Summary

Virtual Router MAC Address: 00:1c:73:00:dc:01

#### Virtual Router MAC Address Device Configuration

```eos
!
ip virtual-router mac-address 00:1c:73:00:dc:01
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| Blue | True |
| Green | True |
| Red | True |

#### IP Routing Device Configuration

```eos
!
ip routing
ip routing vrf Blue
ip routing vrf Green
ip routing vrf Red
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| Blue | false |
| default | false |
| Green | false |
| Red | false |

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| default | 0.0.0.0/0 | 192.168.0.1 | - | 1 | - | - | - |

#### Static Routes Device Configuration

```eos
!
ip route 0.0.0.0/0 192.168.0.1
```

### Router BGP

ASN Notation: asplain

#### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65303 | 192.168.224.35 |

| BGP Tuning |
| ---------- |
| no bgp default ipv4-unicast |
| maximum-paths 4 ecmp 4 |

#### Router BGP Peer Groups

##### EVPN-OVERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Source | Loopback0 |
| BFD | True |
| Ebgp multihop | 3 |
| Send community | all |
| Maximum routes | 0 (no limit) |

##### IPv4-UNDERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Send community | all |
| Maximum routes | 12000 |

##### MLAG-IPv4-UNDERLAY-PEER

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Remote AS | 65303 |
| Next-hop self | True |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.255.254.69 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | default | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 172.31.254.136 | 65101 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 172.31.254.138 | 65101 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 192.168.224.31 | 65101 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 192.168.224.32 | 65101 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.255.254.69 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Blue | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.255.254.69 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Green | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.255.254.69 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Red | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Route-map In | Route-map Out | Peer-tag In | Peer-tag Out | Encapsulation | Next-hop-self Source Interface |
| ---------- | -------- | ------------ | ------------- | ----------- | ------------ | ------------- | ------------------------------ |
| EVPN-OVERLAY-PEERS | True | - | - | - | - | default | - |

#### Router BGP VLAN Aware Bundles

| VLAN Aware Bundle | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute | VLANs |
| ----------------- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ | ----- |
| Blue | 192.168.224.35:10 | 10:10 | - | - | learned | 110-113 |
| Green | 192.168.224.35:12 | 12:12 | - | - | learned | 130-131 |
| Red | 192.168.224.35:11 | 11:11 | - | - | learned | 120-121 |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute | Graceful Restart |
| --- | ------------------- | ------------ | ---------------- |
| Blue | 192.168.224.35:10 | connected | - |
| Green | 192.168.224.35:12 | connected | - |
| Red | 192.168.224.35:11 | connected | - |

#### Router BGP Device Configuration

```eos
!
router bgp 65303
   router-id 192.168.224.35
   no bgp default ipv4-unicast
   maximum-paths 4 ecmp 4
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS bfd
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 3
   neighbor EVPN-OVERLAY-PEERS password 7 <removed>
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS password 7 <removed>
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER peer group
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65303
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description campus-c-leaf2b
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor MLAG-IPv4-UNDERLAY-PEER password 7 <removed>
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor 10.255.254.69 peer group MLAG-IPv4-UNDERLAY-PEER
   neighbor 10.255.254.69 description campus-c-leaf2b_Vlan4093
   neighbor 172.31.254.136 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.254.136 remote-as 65101
   neighbor 172.31.254.136 description campus-c-spine1_Ethernet7
   neighbor 172.31.254.138 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.254.138 remote-as 65101
   neighbor 172.31.254.138 description campus-c-spine2_Ethernet7
   neighbor 192.168.224.31 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.224.31 remote-as 65101
   neighbor 192.168.224.31 description campus-c-spine1_Loopback0
   neighbor 192.168.224.32 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.224.32 remote-as 65101
   neighbor 192.168.224.32 description campus-c-spine2_Loopback0
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan-aware-bundle Blue
      rd 192.168.224.35:10
      route-target both 10:10
      redistribute learned
      vlan 110-113
   !
   vlan-aware-bundle Green
      rd 192.168.224.35:12
      route-target both 12:12
      redistribute learned
      vlan 130-131
   !
   vlan-aware-bundle Red
      rd 192.168.224.35:11
      route-target both 11:11
      redistribute learned
      vlan 120-121
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf Blue
      rd 192.168.224.35:10
      route-target import evpn 10:10
      route-target export evpn 10:10
      router-id 192.168.224.35
      neighbor 10.255.254.69 peer group MLAG-IPv4-UNDERLAY-PEER
      neighbor 10.255.254.69 description campus-c-leaf2b_Vlan3009
      redistribute connected route-map RM-CONN-2-BGP-VRFS
   !
   vrf Green
      rd 192.168.224.35:12
      route-target import evpn 12:12
      route-target export evpn 12:12
      router-id 192.168.224.35
      neighbor 10.255.254.69 peer group MLAG-IPv4-UNDERLAY-PEER
      neighbor 10.255.254.69 description campus-c-leaf2b_Vlan3011
      redistribute connected route-map RM-CONN-2-BGP-VRFS
   !
   vrf Red
      rd 192.168.224.35:11
      route-target import evpn 11:11
      route-target export evpn 11:11
      router-id 192.168.224.35
      neighbor 10.255.254.69 peer group MLAG-IPv4-UNDERLAY-PEER
      neighbor 10.255.254.69 description campus-c-leaf2b_Vlan3010
      redistribute connected route-map RM-CONN-2-BGP-VRFS
```

## BFD

### Router BFD

#### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 1200 | 1200 | 3 |

#### Router BFD Device Configuration

```eos
!
router bfd
   multihop interval 1200 min-rx 1200 multiplier 3
```

## Multicast

### IP IGMP Snooping

#### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Enabled | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
```

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 192.168.224.0/24 eq 32 |
| 20 | permit 192.168.223.0/24 eq 32 |

##### PL-MLAG-PEER-VRFS

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.255.254.68/31 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 192.168.224.0/24 eq 32
   seq 20 permit 192.168.223.0/24 eq 32
!
ip prefix-list PL-MLAG-PEER-VRFS
   seq 10 permit 10.255.254.68/31
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |

##### RM-CONN-2-BGP-VRFS

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | deny | ip address prefix-list PL-MLAG-PEER-VRFS | - | - | - |
| 20 | permit | - | - | - | - |

##### RM-MLAG-PEER-IN

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | - | origin incomplete | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
!
route-map RM-CONN-2-BGP-VRFS deny 10
   match ip address prefix-list PL-MLAG-PEER-VRFS
!
route-map RM-CONN-2-BGP-VRFS permit 20
!
route-map RM-MLAG-PEER-IN permit 10
   description Make routes learned over MLAG Peer-link less preferred on spines to ensure optimal routing
   set origin incomplete
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| Blue | enabled |
| Green | enabled |
| Red | enabled |

### VRF Instances Device Configuration

```eos
!
vrf instance Blue
!
vrf instance Green
!
vrf instance Red
```

## Virtual Source NAT

### Virtual Source NAT Summary

| Source NAT VRF | Source NAT IPv4 Address | Source NAT IPv6 Address |
| -------------- | ----------------------- | ----------------------- |
| Blue | 192.168.200.35 | - |

### Virtual Source NAT Configuration

```eos
!
ip address virtual source-nat vrf Blue address 192.168.200.35
```

## EOS CLI Device Configuration

```eos
!
no schedule tech-support
```
