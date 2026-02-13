# campus-b-leaf1a

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
- [EOS CLI Device Configuration](#eos-cli-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | OOB_MANAGEMENT | oob | default | 192.168.0.43/24 | 192.168.0.1 |

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
   ip address 192.168.0.43/24
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
| - | HCA CAMPUS_B campus-b-leaf1a | All | Disabled |

#### SNMP Device Configuration

```eos
!
snmp-server location HCA CAMPUS_B campus-b-leaf1a
```

## MLAG

### MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| campus-b-leaf1 | Vlan4094 | 10.255.255.45 | Port-Channel11 |

Dual primary detection is enabled. The detection delay is 5 seconds.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id campus-b-leaf1
   local-interface Vlan4094
   peer-address 10.255.255.45
   peer-address heartbeat 192.168.0.44
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
| 10 | MGMT | - |
| 20 | USER | - |
| 30 | VOICE | - |
| 40 | PACS | - |
| 4093 | MLAG_L3 | MLAG |
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
| Ethernet5 | SERVER_campus-b-leaf1-server1_Ethernet1 | *access | *10,20,30,40,110 | *- | *- | 5 |
| Ethernet6 | L2_campus-b-leaf2d_Ethernet1 | *trunk | *10,20,30,40 | *- | *- | 6 |
| Ethernet11 | MLAG_campus-b-leaf1b_Ethernet11 | *trunk | *2-4094 | *- | *MLAG | 11 |
| Ethernet12 | MLAG_campus-b-leaf1b_Ethernet12 | *trunk | *2-4094 | *- | *MLAG | 11 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_campus-b-spine1_Ethernet5 | - | 172.16.0.89/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_campus-b-spine2_Ethernet5 | - | 172.16.0.91/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_campus-b-spine1_Ethernet5
   no shutdown
   mtu 1500
   no switchport
   ip address 172.16.0.89/31
!
interface Ethernet2
   description P2P_campus-b-spine2_Ethernet5
   no shutdown
   mtu 1500
   no switchport
   ip address 172.16.0.91/31
!
interface Ethernet5
   description SERVER_campus-b-leaf1-server1_Ethernet1
   no shutdown
   channel-group 5 mode active
!
interface Ethernet6
   description L2_campus-b-leaf2d_Ethernet1
   no shutdown
   channel-group 6 mode active
!
interface Ethernet11
   description MLAG_campus-b-leaf1b_Ethernet11
   no shutdown
   channel-group 11 mode active
!
interface Ethernet12
   description MLAG_campus-b-leaf1b_Ethernet12
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
| Port-Channel5 | SERVER_campus-b-leaf1-server1 | access | 10,20,30,40,110 | - | - | - | - | 5 | - |
| Port-Channel6 | L2_campus-b-leaf2d_Port-Channel1 | trunk | 10,20,30,40 | - | - | - | - | 6 | - |
| Port-Channel11 | MLAG_campus-b-leaf1b_Port-Channel11 | trunk | 2-4094 | - | MLAG | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel5
   description SERVER_campus-b-leaf1-server1
   no shutdown
   switchport access vlan 110
   switchport trunk allowed vlan 10,20,30,40
   switchport mode access
   switchport
   mlag 5
!
interface Port-Channel6
   description L2_campus-b-leaf2d_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10,20,30,40
   switchport mode trunk
   switchport
   mlag 6
!
interface Port-Channel11
   description MLAG_campus-b-leaf1b_Port-Channel11
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
| Loopback0 | ROUTER_ID | default | 172.16.20.23/32 |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | 172.16.21.23/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | ROUTER_ID | default | - |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description ROUTER_ID
   no shutdown
   ip address 172.16.20.23/32
!
interface Loopback1
   description VXLAN_TUNNEL_SOURCE
   no shutdown
   ip address 172.16.21.23/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan10 | MGMT | default | - | False |
| Vlan20 | USER | default | - | False |
| Vlan30 | VOICE | default | - | False |
| Vlan40 | PACS | default | - | False |
| Vlan4093 | MLAG_L3 | default | 1500 | False |
| Vlan4094 | MLAG | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan10 |  default  |  -  |  10.20.10.1/24  |  -  |  -  |  -  |
| Vlan20 |  default  |  -  |  10.20.20.1/24  |  -  |  -  |  -  |
| Vlan30 |  default  |  -  |  10.20.30.1/24  |  -  |  -  |  -  |
| Vlan40 |  default  |  -  |  10.20.40.1/24  |  -  |  -  |  -  |
| Vlan4093 |  default  |  10.255.254.44/31  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  10.255.255.44/31  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan10
   description MGMT
   no shutdown
   ip address virtual 10.20.10.1/24
!
interface Vlan20
   description USER
   no shutdown
   ip address virtual 10.20.20.1/24
!
interface Vlan30
   description VOICE
   no shutdown
   ip address virtual 10.20.30.1/24
!
interface Vlan40
   description PACS
   no shutdown
   ip address virtual 10.20.40.1/24
!
interface Vlan4093
   description MLAG_L3
   no shutdown
   mtu 1500
   ip address 10.255.254.44/31
!
interface Vlan4094
   description MLAG
   no shutdown
   mtu 1500
   no autostate
   ip address 10.255.255.44/31
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
| 10 | 10010 | - | - |
| 20 | 10020 | - | - |
| 30 | 10030 | - | - |
| 40 | 10040 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Overlay Multicast Group to Encap Mappings |
| --- | --- | ----------------------------------------- |
| default | 10 | - |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description campus-b-leaf1a_VTEP
   vxlan source-interface Loopback1
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 10 vni 10010
   vxlan vlan 20 vni 10020
   vxlan vlan 30 vni 10030
   vxlan vlan 40 vni 10040
   vxlan vrf default vni 10
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
| 65201 | 172.16.20.23 |

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
| Remote AS | 65201 |
| Next-hop self | True |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.255.254.45 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | default | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 172.16.0.88 | 65100 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 172.16.0.90 | 65100 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 192.168.234.21 | 65100 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 192.168.234.22 | 65100 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Route-map In | Route-map Out | Peer-tag In | Peer-tag Out | Encapsulation | Next-hop-self Source Interface |
| ---------- | -------- | ------------ | ------------- | ----------- | ------------ | ------------- | ------------------------------ |
| EVPN-OVERLAY-PEERS | True | - | - | - | - | default | - |

#### Router BGP VLAN Aware Bundles

| VLAN Aware Bundle | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute | VLANs |
| ----------------- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ | ----- |
| default | 172.16.20.23:10 | 10:10 | - | - | learned | 10,20,30,40 |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute | Graceful Restart |
| --- | ------------------- | ------------ | ---------------- |
| default | 172.16.20.23:10 | - | - |

#### Router BGP Device Configuration

```eos
!
router bgp 65201
   router-id 172.16.20.23
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
   neighbor IPv4-UNDERLAY-PEERS route-map RM-BGP-UNDERLAY-PEERS-OUT out
   neighbor IPv4-UNDERLAY-PEERS password 7 <removed>
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER peer group
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65201
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description campus-b-leaf1b
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor MLAG-IPv4-UNDERLAY-PEER password 7 <removed>
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor 10.255.254.45 peer group MLAG-IPv4-UNDERLAY-PEER
   neighbor 10.255.254.45 description campus-b-leaf1b_Vlan4093
   neighbor 172.16.0.88 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.16.0.88 remote-as 65100
   neighbor 172.16.0.88 description campus-b-spine1_Ethernet5
   neighbor 172.16.0.90 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.16.0.90 remote-as 65100
   neighbor 172.16.0.90 description campus-b-spine2_Ethernet5
   neighbor 192.168.234.21 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.234.21 remote-as 65100
   neighbor 192.168.234.21 description campus-b-spine1_Loopback0
   neighbor 192.168.234.22 peer group EVPN-OVERLAY-PEERS
   neighbor 192.168.234.22 remote-as 65100
   neighbor 192.168.234.22 description campus-b-spine2_Loopback0
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan-aware-bundle default
      rd 172.16.20.23:10
      route-target both 10:10
      redistribute learned
      vlan 10,20,30,40
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf default
      rd 172.16.20.23:10
      route-target import evpn 10:10
      route-target export evpn 10:10
      route-target export evpn route-map RM-EVPN-EXPORT-VRF-DEFAULT
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
| 10 | permit 172.16.20.0/24 eq 32 |
| 20 | permit 172.16.21.0/24 eq 32 |

##### PL-SVI-VRF-DEFAULT

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.20.10.0/24 |
| 20 | permit 10.20.20.0/24 |
| 30 | permit 10.20.30.0/24 |
| 40 | permit 10.20.40.0/24 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 172.16.20.0/24 eq 32
   seq 20 permit 172.16.21.0/24 eq 32
!
ip prefix-list PL-SVI-VRF-DEFAULT
   seq 10 permit 10.20.10.0/24
   seq 20 permit 10.20.20.0/24
   seq 30 permit 10.20.30.0/24
   seq 40 permit 10.20.40.0/24
```

### Route-maps

#### Route-maps Summary

##### RM-BGP-UNDERLAY-PEERS-OUT

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | deny | ip address prefix-list PL-SVI-VRF-DEFAULT | - | - | - |
| 20 | permit | - | - | - | - |

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |
| 30 | permit | ip address prefix-list PL-SVI-VRF-DEFAULT | - | - | - |

##### RM-EVPN-EXPORT-VRF-DEFAULT

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-SVI-VRF-DEFAULT | - | - | - |

##### RM-MLAG-PEER-IN

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | - | origin incomplete | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-BGP-UNDERLAY-PEERS-OUT deny 10
   match ip address prefix-list PL-SVI-VRF-DEFAULT
!
route-map RM-BGP-UNDERLAY-PEERS-OUT permit 20
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
!
route-map RM-CONN-2-BGP permit 30
   match ip address prefix-list PL-SVI-VRF-DEFAULT
!
route-map RM-EVPN-EXPORT-VRF-DEFAULT permit 10
   match ip address prefix-list PL-SVI-VRF-DEFAULT
!
route-map RM-MLAG-PEER-IN permit 10
   description Make routes learned over MLAG Peer-link less preferred on spines to ensure optimal routing
   set origin incomplete
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
