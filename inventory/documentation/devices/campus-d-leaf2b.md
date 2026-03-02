# campus-d-leaf2b

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
- [Authentication](#authentication)
  - [Enable Password](#enable-password)
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
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | OOB_MANAGEMENT | oob | MGMT | 192.168.0.66 | 192.168.0.1 |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management1 | OOB_MANAGEMENT | oob | MGMT | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management1
   description OOB_MANAGEMENT
   no shutdown
   vrf MGMT
   ip address 192.168.0.66
```

## Authentication

### Enable Password

Enable password has been disabled

## MLAG

### MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| campus-d-leaf2 | Vlan4094 | 192.168.255.4 | Port-Channel11 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id campus-d-leaf2
   local-interface Vlan4094
   peer-address 192.168.255.4
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

- Spanning Tree disabled for VLANs: **4094**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
no spanning-tree vlan-id 4094
spanning-tree mst 0 priority 32768
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ----------------- | --------------- | ------------ |
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
vlan 4094
   name MLAG
   trunk group MLAG
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet1 | L2_campus-d-spine1_Ethernet8 | *trunk | *10,20,30,40 | *- | *- | 1 |
| Ethernet2 | L2_campus-d-spine2_Ethernet8 | *trunk | *10,20,30,40 | *- | *- | 1 |
| Ethernet5 | L2_campus-d-leaf2c_Ethernet2 | *trunk | *10,20,30,40 | *- | *- | 5 |
| Ethernet6 | L2_campus-d-leaf2d_Ethernet2 | *trunk | *10,20,30,40 | *- | *- | 6 |
| Ethernet11 | MLAG_campus-d-leaf2a_Ethernet11 | *trunk | *2-4094 | *- | *MLAG | 11 |
| Ethernet12 | MLAG_campus-d-leaf2a_Ethernet12 | *trunk | *2-4094 | *- | *MLAG | 11 |

*Inherited from Port-Channel Interface

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description L2_campus-d-spine1_Ethernet8
   no shutdown
   channel-group 1 mode active
!
interface Ethernet2
   description L2_campus-d-spine2_Ethernet8
   no shutdown
   channel-group 1 mode active
!
interface Ethernet5
   description L2_campus-d-leaf2c_Ethernet2
   no shutdown
   channel-group 5 mode active
!
interface Ethernet6
   description L2_campus-d-leaf2d_Ethernet2
   no shutdown
   channel-group 6 mode active
!
interface Ethernet11
   description MLAG_campus-d-leaf2a_Ethernet11
   no shutdown
   channel-group 11 mode active
!
interface Ethernet12
   description MLAG_campus-d-leaf2a_Ethernet12
   no shutdown
   channel-group 11 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | --------------------- | ------------------ | ------- | -------- |
| Port-Channel1 | L2_campus-d-spines_Port-Channel7 | trunk | 10,20,30,40 | - | - | - | - | 1 | - |
| Port-Channel5 | L2_campus-d-leaf2c_Port-Channel1 | trunk | 10,20,30,40 | - | - | - | - | 5 | - |
| Port-Channel6 | L2_campus-d-leaf2d_Port-Channel1 | trunk | 10,20,30,40 | - | - | - | - | 6 | - |
| Port-Channel11 | MLAG_campus-d-leaf2a_Port-Channel11 | trunk | 2-4094 | - | MLAG | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel1
   description L2_campus-d-spines_Port-Channel7
   no shutdown
   switchport trunk allowed vlan 10,20,30,40
   switchport mode trunk
   switchport
   mlag 1
!
interface Port-Channel5
   description L2_campus-d-leaf2c_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10,20,30,40
   switchport mode trunk
   switchport
   mlag 5
!
interface Port-Channel6
   description L2_campus-d-leaf2d_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10,20,30,40
   switchport mode trunk
   switchport
   mlag 6
!
interface Port-Channel11
   description MLAG_campus-d-leaf2a_Port-Channel11
   no shutdown
   switchport trunk allowed vlan 2-4094
   switchport mode trunk
   switchport trunk group MLAG
   switchport
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF | MTU | Shutdown |
| --------- | ----------- | --- | --- | -------- |
| Vlan4094 | MLAG | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan4094 | default | 192.168.255.5/31 | - | - | - | - |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan4094
   description MLAG
   no shutdown
   mtu 1500
   no autostate
   ip address 192.168.255.5/31
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| MGMT | False |

#### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| MGMT | false |

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| MGMT | 0.0.0.0/0 | 192.168.0.1 | - | 1 | - | - | - |

#### Static Routes Device Configuration

```eos
!
ip route vrf MGMT 0.0.0.0/0 192.168.0.1
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

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| MGMT | disabled |

### VRF Instances Device Configuration

```eos
!
vrf instance MGMT
```
