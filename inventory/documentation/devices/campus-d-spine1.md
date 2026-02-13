# campus-d-spine1

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
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [Router BGP](#router-bgp)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [EOS CLI Device Configuration](#eos-cli-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | OOB_MANAGEMENT | oob | default | 192.168.0.61 | 192.168.0.1 |

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
   ip address 192.168.0.61
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

sha512 encrypted enable password is configured

#### Enable Password Device Configuration

```eos
!
enable password sha512 <removed>
!
```

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
| - | HCA CAMPUS campus-d-spine1 | All | Disabled |

#### SNMP Device Configuration

```eos
!
snmp-server location HCA CAMPUS campus-d-spine1
```

## MLAG

### MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| campus-d-spines | Vlan4094 | 192.168.255.1 | Port-Channel11 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id campus-d-spines
   local-interface Vlan4094
   peer-address 192.168.255.1
   peer-link Port-Channel11
   reload-delay mlag 300
   reload-delay non-mlag 330
```

## Spanning Tree

### Spanning Tree Summary

STP mode: **mstp**

#### MSTP Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 0 | 32768 |

#### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4093-4094**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
no spanning-tree vlan-id 4093-4094
spanning-tree mst 0 priority 32768
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
| 10 | MGMT | - |
| 20 | USER | - |
| 30 | VOICE | - |
| 40 | PACS | - |
| 3009 | MLAG_L3_VRF_default | MLAG |
| 4094 | MLAG | MLAG |

### VLANs Device Configuration

```eos
!
vlan 10
   name MGMT
!
vlan 20
   name USER
!
vlan 30
   name VOICE
!
vlan 40
   name PACS
!
vlan 3009
   name MLAG_L3_VRF_default
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
| Ethernet5 | L2_campus-d-leaf1a_Ethernet1 | *trunk | *10,20,30,40 | *- | *- | 5 |
| Ethernet6 | L2_campus-d-leaf1b_Ethernet1 | *trunk | *10,20,30,40 | *- | *- | 5 |
| Ethernet7 | L2_campus-d-leaf2a_Ethernet1 | *trunk | *10,20,30,40 | *- | *- | 7 |
| Ethernet8 | L2_campus-d-leaf2b_Ethernet1 | *trunk | *10,20,30,40 | *- | *- | 7 |
| Ethernet11 | MLAG_campus-d-spine2_Ethernet11 | *trunk | *2-4094 | *- | *MLAG | 11 |
| Ethernet12 | MLAG_campus-d-spine2_Ethernet12 | *trunk | *2-4094 | *- | *MLAG | 11 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | - | - | 169.254.40.0/31 | default | - | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   no shutdown
   no switchport
   ip address 169.254.40.0/31
!
interface Ethernet5
   description L2_campus-d-leaf1a_Ethernet1
   no shutdown
   channel-group 5 mode active
!
interface Ethernet6
   description L2_campus-d-leaf1b_Ethernet1
   no shutdown
   channel-group 5 mode active
!
interface Ethernet7
   description L2_campus-d-leaf2a_Ethernet1
   no shutdown
   channel-group 7 mode active
!
interface Ethernet8
   description L2_campus-d-leaf2b_Ethernet1
   no shutdown
   channel-group 7 mode active
!
interface Ethernet11
   description MLAG_campus-d-spine2_Ethernet11
   no shutdown
   channel-group 11 mode active
!
interface Ethernet12
   description MLAG_campus-d-spine2_Ethernet12
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
| Port-Channel5 | L2_campus-d-leaf1_Port-Channel1 | trunk | 10,20,30,40 | - | - | - | - | 5 | - |
| Port-Channel7 | L2_campus-d-leaf2_Port-Channel1 | trunk | 10,20,30,40 | - | - | - | - | 7 | - |
| Port-Channel11 | MLAG_campus-d-spine2_Port-Channel11 | trunk | 2-4094 | - | MLAG | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel5
   description L2_campus-d-leaf1_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10,20,30,40
   switchport mode trunk
   switchport
   mlag 5
!
interface Port-Channel7
   description L2_campus-d-leaf2_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10,20,30,40
   switchport mode trunk
   switchport
   mlag 7
!
interface Port-Channel11
   description MLAG_campus-d-spine2_Port-Channel11
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
| Loopback0 | ROUTER_ID | default | 172.16.40.1/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | ROUTER_ID | default | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description ROUTER_ID
   no shutdown
   ip address 172.16.40.1/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan10 | MGMT | default | - | False |
| Vlan20 | USER | default | - | False |
| Vlan30 | VOICE | default | - | False |
| Vlan40 | PACS | default | - | False |
| Vlan3009 | MLAG_L3_VRF_default | default | 1500 | False |
| Vlan4094 | MLAG | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan10 |  default  |  -  |  10.40.10.1/24  |  -  |  -  |  -  |
| Vlan20 |  default  |  -  |  10.40.20.1/24  |  -  |  -  |  -  |
| Vlan30 |  default  |  -  |  10.40.30.1/24  |  -  |  -  |  -  |
| Vlan40 |  default  |  -  |  10.40.40.1/24  |  -  |  -  |  -  |
| Vlan3009 |  default  |  192.168.254.0/31  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  192.168.255.0/31  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan10
   description MGMT
   no shutdown
   ip address virtual 10.40.10.1/24
!
interface Vlan20
   description USER
   no shutdown
   ip address virtual 10.40.20.1/24
!
interface Vlan30
   description VOICE
   no shutdown
   ip address virtual 10.40.30.1/24
!
interface Vlan40
   description PACS
   no shutdown
   ip address virtual 10.40.40.1/24
!
interface Vlan3009
   description MLAG_L3_VRF_default
   no shutdown
   mtu 1500
   vrf default
   ip address 192.168.254.0/31
!
interface Vlan4094
   description MLAG
   no shutdown
   mtu 1500
   no autostate
   ip address 192.168.255.0/31
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

#### IP Routing Device Configuration

```eos
!
ip routing
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| default | false |

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
| 65401 | - |

| BGP Tuning |
| ---------- |
| graceful-restart |
| no bgp default ipv4-unicast |
| distance bgp 20 200 200 |
| maximum-paths 4 ecmp 4 |

#### Router BGP Peer Groups

##### WAN

| Settings | Value |
| -------- | ----- |
| Remote AS | 65534 |
| BFD | True |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 169.254.40.1 | Inherited from peer group WAN | default | - | Inherited from peer group WAN | Inherited from peer group WAN | - | Inherited from peer group WAN | - | - | - | - |

#### Router BGP Device Configuration

```eos
!
router bgp 65401
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   graceful-restart
   maximum-paths 4 ecmp 4
   neighbor WAN peer group
   neighbor WAN remote-as 65534
   neighbor WAN bfd
   neighbor WAN description WAN Routers
   neighbor WAN send-community
   neighbor WAN maximum-routes 12000
   neighbor 169.254.40.1 peer group WAN
   neighbor 169.254.40.1 description WAN Router
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

##### PL-MLAG-PEER-VRFS

| Sequence | Action |
| -------- | ------ |
| 10 | permit 192.168.254.0/31 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-MLAG-PEER-VRFS
   seq 10 permit 192.168.254.0/31
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP-VRFS

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | deny | ip address prefix-list PL-MLAG-PEER-VRFS | - | - | - |
| 20 | permit | - | - | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP-VRFS deny 10
   match ip address prefix-list PL-MLAG-PEER-VRFS
!
route-map RM-CONN-2-BGP-VRFS permit 20
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |

### VRF Instances Device Configuration

```eos
```

## EOS CLI Device Configuration

```eos
!
no schedule tech-support
```
