# HCA

## Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision | Serial Number |
| --- | ---- | ---- | ------------- | -------- | -------------------------- | ------------- |
| CAMPUS_A | l3leaf | campus-a-leaf1a | 192.168.0.33/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_A | l3leaf | campus-a-leaf1b | 192.168.0.34/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_A | l3leaf | campus-a-leaf2a | 192.168.0.35/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_A | l3leaf | campus-a-leaf2b | 192.168.0.36/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_A | l2leaf | campus-a-leaf2c | 192.168.0.41/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_A | l2leaf | campus-a-leaf2d | 192.168.0.42/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_A | spine | campus-a-spine1 | 192.168.0.31/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_A | spine | campus-a-spine2 | 192.168.0.32/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | l3leaf | campus-b-leaf1a | 192.168.0.43/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | l3leaf | campus-b-leaf1b | 192.168.0.44/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | l3leaf | campus-b-leaf2a | 192.168.0.45/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | l3leaf | campus-b-leaf2b | 192.168.0.46/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | l2leaf | campus-b-leaf2c | 192.168.0.47/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | l2leaf | campus-b-leaf2d | 192.168.0.48/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | spine | campus-b-spine1 | 192.168.0.41/24 | vEOS-LAB | Provisioned | - |
| CAMPUS_B | spine | campus-b-spine2 | 192.168.0.42/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | l3leaf | campus-c-leaf1a | 192.168.0.53/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | l3leaf | campus-c-leaf1b | 192.168.0.54/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | l3leaf | campus-c-leaf2a | 192.168.0.55/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | l3leaf | campus-c-leaf2b | 192.168.0.56/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | l2leaf | campus-c-leaf2c | 192.168.0.57/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | l2leaf | campus-c-leaf2d | 192.168.0.58/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | spine | campus-c-spine1 | 192.168.0.51/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | spine | campus-c-spine2 | 192.168.0.52/24 | vEOS-LAB | Provisioned | - |
| CAMPUS | l2leaf | campus-d-leaf1a | 192.168.0.63 | vEOS | Provisioned | - |
| CAMPUS | l2leaf | campus-d-leaf1b | 192.168.0.64 | vEOS | Provisioned | - |
| CAMPUS | l2leaf | campus-d-leaf2a | 192.168.0.65 | vEOS | Provisioned | - |
| CAMPUS | l2leaf | campus-d-leaf2b | 192.168.0.66 | vEOS | Provisioned | - |
| CAMPUS | l2leaf | campus-d-leaf2c | 192.168.0.67 | vEOS | Provisioned | - |
| CAMPUS | l2leaf | campus-d-leaf2d | 192.168.0.68 | vEOS | Provisioned | - |
| CAMPUS | l3spine | campus-d-spine1 | 192.168.0.61 | vEOS | Provisioned | - |
| CAMPUS | l3spine | campus-d-spine2 | 192.168.0.62 | vEOS | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | campus-a-leaf1a | Ethernet1 | spine | campus-a-spine1 | Ethernet5 |
| l3leaf | campus-a-leaf1a | Ethernet2 | spine | campus-a-spine2 | Ethernet5 |
| l3leaf | campus-a-leaf1a | Ethernet5 | l2leaf | campus-a-leaf2c | Ethernet1 |
| l3leaf | campus-a-leaf1a | Ethernet6 | l2leaf | campus-a-leaf2d | Ethernet1 |
| l3leaf | campus-a-leaf1a | Ethernet11 | mlag_peer | campus-a-leaf1b | Ethernet11 |
| l3leaf | campus-a-leaf1a | Ethernet12 | mlag_peer | campus-a-leaf1b | Ethernet12 |
| l3leaf | campus-a-leaf1b | Ethernet1 | spine | campus-a-spine1 | Ethernet6 |
| l3leaf | campus-a-leaf1b | Ethernet2 | spine | campus-a-spine2 | Ethernet6 |
| l3leaf | campus-a-leaf1b | Ethernet5 | l2leaf | campus-a-leaf2c | Ethernet2 |
| l3leaf | campus-a-leaf1b | Ethernet6 | l2leaf | campus-a-leaf2d | Ethernet2 |
| l3leaf | campus-a-leaf2a | Ethernet11 | mlag_peer | campus-a-leaf2b | Ethernet11 |
| l3leaf | campus-a-leaf2a | Ethernet12 | mlag_peer | campus-a-leaf2b | Ethernet12 |
| l3leaf | campus-b-leaf1a | Ethernet1 | spine | campus-b-spine1 | Ethernet5 |
| l3leaf | campus-b-leaf1a | Ethernet2 | spine | campus-b-spine2 | Ethernet5 |
| l3leaf | campus-b-leaf1a | Ethernet5 | l2leaf | campus-b-leaf2c | Ethernet1 |
| l3leaf | campus-b-leaf1a | Ethernet6 | l2leaf | campus-b-leaf2d | Ethernet1 |
| l3leaf | campus-b-leaf1a | Ethernet11 | mlag_peer | campus-b-leaf1b | Ethernet11 |
| l3leaf | campus-b-leaf1a | Ethernet12 | mlag_peer | campus-b-leaf1b | Ethernet12 |
| l3leaf | campus-b-leaf1b | Ethernet1 | spine | campus-b-spine1 | Ethernet6 |
| l3leaf | campus-b-leaf1b | Ethernet2 | spine | campus-b-spine2 | Ethernet6 |
| l3leaf | campus-b-leaf1b | Ethernet5 | l2leaf | campus-b-leaf2c | Ethernet2 |
| l3leaf | campus-b-leaf1b | Ethernet6 | l2leaf | campus-b-leaf2d | Ethernet2 |
| l3leaf | campus-b-leaf2a | Ethernet11 | mlag_peer | campus-b-leaf2b | Ethernet11 |
| l3leaf | campus-b-leaf2a | Ethernet12 | mlag_peer | campus-b-leaf2b | Ethernet12 |
| l3leaf | campus-c-leaf1a | Ethernet1 | spine | campus-c-spine1 | Ethernet5 |
| l3leaf | campus-c-leaf1a | Ethernet2 | spine | campus-c-spine2 | Ethernet5 |
| l3leaf | campus-c-leaf1a | Ethernet5 | l2leaf | campus-c-leaf2c | Ethernet1 |
| l3leaf | campus-c-leaf1a | Ethernet6 | l2leaf | campus-c-leaf2d | Ethernet1 |
| l3leaf | campus-c-leaf1a | Ethernet11 | mlag_peer | campus-c-leaf1b | Ethernet11 |
| l3leaf | campus-c-leaf1a | Ethernet12 | mlag_peer | campus-c-leaf1b | Ethernet12 |
| l3leaf | campus-c-leaf1b | Ethernet1 | spine | campus-c-spine1 | Ethernet6 |
| l3leaf | campus-c-leaf1b | Ethernet2 | spine | campus-c-spine2 | Ethernet6 |
| l3leaf | campus-c-leaf1b | Ethernet5 | l2leaf | campus-c-leaf2c | Ethernet2 |
| l3leaf | campus-c-leaf1b | Ethernet6 | l2leaf | campus-c-leaf2d | Ethernet2 |
| l3leaf | campus-c-leaf2a | Ethernet1 | spine | campus-c-spine1 | Ethernet7 |
| l3leaf | campus-c-leaf2a | Ethernet2 | spine | campus-c-spine2 | Ethernet7 |
| l3leaf | campus-c-leaf2a | Ethernet11 | mlag_peer | campus-c-leaf2b | Ethernet11 |
| l3leaf | campus-c-leaf2a | Ethernet12 | mlag_peer | campus-c-leaf2b | Ethernet12 |
| l3leaf | campus-c-leaf2b | Ethernet1 | spine | campus-c-spine1 | Ethernet8 |
| l3leaf | campus-c-leaf2b | Ethernet2 | spine | campus-c-spine2 | Ethernet8 |
| l2leaf | campus-d-leaf1a | Ethernet1 | l3spine | campus-d-spine1 | Ethernet5 |
| l2leaf | campus-d-leaf1a | Ethernet2 | l3spine | campus-d-spine2 | Ethernet5 |
| l2leaf | campus-d-leaf1a | Ethernet11 | mlag_peer | campus-d-leaf1b | Ethernet11 |
| l2leaf | campus-d-leaf1a | Ethernet12 | mlag_peer | campus-d-leaf1b | Ethernet12 |
| l2leaf | campus-d-leaf1b | Ethernet1 | l3spine | campus-d-spine1 | Ethernet6 |
| l2leaf | campus-d-leaf1b | Ethernet2 | l3spine | campus-d-spine2 | Ethernet6 |
| l2leaf | campus-d-leaf2a | Ethernet1 | l3spine | campus-d-spine1 | Ethernet7 |
| l2leaf | campus-d-leaf2a | Ethernet2 | l3spine | campus-d-spine2 | Ethernet7 |
| l2leaf | campus-d-leaf2a | Ethernet5 | l2leaf | campus-d-leaf2c | Ethernet1 |
| l2leaf | campus-d-leaf2a | Ethernet6 | l2leaf | campus-d-leaf2d | Ethernet1 |
| l2leaf | campus-d-leaf2a | Ethernet11 | mlag_peer | campus-d-leaf2b | Ethernet11 |
| l2leaf | campus-d-leaf2a | Ethernet12 | mlag_peer | campus-d-leaf2b | Ethernet12 |
| l2leaf | campus-d-leaf2b | Ethernet1 | l3spine | campus-d-spine1 | Ethernet8 |
| l2leaf | campus-d-leaf2b | Ethernet2 | l3spine | campus-d-spine2 | Ethernet8 |
| l2leaf | campus-d-leaf2b | Ethernet5 | l2leaf | campus-d-leaf2c | Ethernet2 |
| l2leaf | campus-d-leaf2b | Ethernet6 | l2leaf | campus-d-leaf2d | Ethernet2 |
| l3spine | campus-d-spine1 | Ethernet11 | mlag_peer | campus-d-spine2 | Ethernet11 |
| l3spine | campus-d-spine1 | Ethernet12 | mlag_peer | campus-d-spine2 | Ethernet12 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 172.16.0.0/24 | 256 | 32 | 12.5 % |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| campus-a-leaf1a | Ethernet1 | 172.16.0.49/31 | campus-a-spine1 | Ethernet5 | 172.16.0.48/31 |
| campus-a-leaf1a | Ethernet2 | 172.16.0.51/31 | campus-a-spine2 | Ethernet5 | 172.16.0.50/31 |
| campus-a-leaf1b | Ethernet1 | 172.16.0.53/31 | campus-a-spine1 | Ethernet6 | 172.16.0.52/31 |
| campus-a-leaf1b | Ethernet2 | 172.16.0.55/31 | campus-a-spine2 | Ethernet6 | 172.16.0.54/31 |
| campus-b-leaf1a | Ethernet1 | 172.16.0.89/31 | campus-b-spine1 | Ethernet5 | 172.16.0.88/31 |
| campus-b-leaf1a | Ethernet2 | 172.16.0.91/31 | campus-b-spine2 | Ethernet5 | 172.16.0.90/31 |
| campus-b-leaf1b | Ethernet1 | 172.16.0.93/31 | campus-b-spine1 | Ethernet6 | 172.16.0.92/31 |
| campus-b-leaf1b | Ethernet2 | 172.16.0.95/31 | campus-b-spine2 | Ethernet6 | 172.16.0.94/31 |
| campus-c-leaf1a | Ethernet1 | 172.16.0.129/31 | campus-c-spine1 | Ethernet5 | 172.16.0.128/31 |
| campus-c-leaf1a | Ethernet2 | 172.16.0.131/31 | campus-c-spine2 | Ethernet5 | 172.16.0.130/31 |
| campus-c-leaf1b | Ethernet1 | 172.16.0.133/31 | campus-c-spine1 | Ethernet6 | 172.16.0.132/31 |
| campus-c-leaf1b | Ethernet2 | 172.16.0.135/31 | campus-c-spine2 | Ethernet6 | 172.16.0.134/31 |
| campus-c-leaf2a | Ethernet1 | 172.16.0.137/31 | campus-c-spine1 | Ethernet7 | 172.16.0.136/31 |
| campus-c-leaf2a | Ethernet2 | 172.16.0.139/31 | campus-c-spine2 | Ethernet7 | 172.16.0.138/31 |
| campus-c-leaf2b | Ethernet1 | 172.16.0.141/31 | campus-c-spine1 | Ethernet8 | 172.16.0.140/31 |
| campus-c-leaf2b | Ethernet2 | 172.16.0.143/31 | campus-c-spine2 | Ethernet8 | 172.16.0.142/31 |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 172.16.10.0/24 | 256 | 4 | 1.57 % |
| 172.16.20.0/24 | 256 | 4 | 1.57 % |
| 172.16.30.0/24 | 256 | 4 | 1.57 % |
| 172.16.40.0/24 | 256 | 2 | 0.79 % |
| 192.168.224.0/24 | 256 | 2 | 0.79 % |
| 192.168.234.0/24 | 256 | 2 | 0.79 % |
| 192.168.244.0/24 | 256 | 2 | 0.79 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| CAMPUS_A | campus-a-leaf1a | 172.16.10.13/32 |
| CAMPUS_A | campus-a-leaf1b | 172.16.10.14/32 |
| CAMPUS_A | campus-a-leaf2a | 172.16.10.15/32 |
| CAMPUS_A | campus-a-leaf2b | 172.16.10.16/32 |
| CAMPUS_A | campus-a-spine1 | 192.168.244.11/32 |
| CAMPUS_A | campus-a-spine2 | 192.168.244.12/32 |
| CAMPUS_B | campus-b-leaf1a | 172.16.20.23/32 |
| CAMPUS_B | campus-b-leaf1b | 172.16.20.24/32 |
| CAMPUS_B | campus-b-leaf2a | 172.16.20.25/32 |
| CAMPUS_B | campus-b-leaf2b | 172.16.20.26/32 |
| CAMPUS_B | campus-b-spine1 | 192.168.234.21/32 |
| CAMPUS_B | campus-b-spine2 | 192.168.234.22/32 |
| CAMPUS | campus-c-leaf1a | 172.16.30.33/32 |
| CAMPUS | campus-c-leaf1b | 172.16.30.34/32 |
| CAMPUS | campus-c-leaf2a | 172.16.30.35/32 |
| CAMPUS | campus-c-leaf2b | 172.16.30.36/32 |
| CAMPUS | campus-c-spine1 | 192.168.224.31/32 |
| CAMPUS | campus-c-spine2 | 192.168.224.32/32 |
| CAMPUS | campus-d-spine1 | 172.16.40.1/32 |
| CAMPUS | campus-d-spine2 | 172.16.40.2/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------------ | ------------------- | ------------------ | ------------------ |
| 172.16.11.0/24 | 256 | 4 | 1.57 % |
| 172.16.21.0/24 | 256 | 4 | 1.57 % |
| 172.16.31.0/24 | 256 | 4 | 1.57 % |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| CAMPUS_A | campus-a-leaf1a | 172.16.11.13/32 |
| CAMPUS_A | campus-a-leaf1b | 172.16.11.13/32 |
| CAMPUS_A | campus-a-leaf2a | 172.16.11.15/32 |
| CAMPUS_A | campus-a-leaf2b | 172.16.11.15/32 |
| CAMPUS_B | campus-b-leaf1a | 172.16.21.23/32 |
| CAMPUS_B | campus-b-leaf1b | 172.16.21.23/32 |
| CAMPUS_B | campus-b-leaf2a | 172.16.21.25/32 |
| CAMPUS_B | campus-b-leaf2b | 172.16.21.25/32 |
| CAMPUS | campus-c-leaf1a | 172.16.31.33/32 |
| CAMPUS | campus-c-leaf1b | 172.16.31.33/32 |
| CAMPUS | campus-c-leaf2a | 172.16.31.35/32 |
| CAMPUS | campus-c-leaf2b | 172.16.31.35/32 |
