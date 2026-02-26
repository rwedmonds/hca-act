## High Availability & Convergence

- nsf (under OSPF): Allows the switch to continue forwarding traffic during a control-plane restart.
  - Arista uses **graceful restart** to enable continuous forwarding during control plane restarts
- fast-reroute per-prefix: Pre-calculates backup paths (LFA) for <50ms recovery.
- bgp nexthop trigger delay 0: Zero-wait reaction to underlay failures.
- fall-over host-route: Forces BGP to die the instant the loopback route is lost.
- carrier-delay msec 0: Instant physical link-loss reporting.
- max-metric router-lsa: This prevents the router from acting as a transit path for network traffic while it converges.
 

## Traffic Engineering & Performance

- ip cef load-sharing algorithm include-ports: Advanced hashing to ensure all uplinks to your Spines are used equally.
- auto-cost reference-bandwidth 1000000: Fixes OSPF cost math for 10G/40G/100G interfaces.
- ip tcp mss 8000: Optimizes large data transfers for the Jumbo MTU (9100) environment.
- ip tcp path-mtu-discovery: is essential for managing the additional overhead created by network virtualization.
- ip tcp window-size 131072: Speeds up the exchange of EVPN route tables. 
 

## EVPN/VXLAN Intelligence

- anycast-gateway mac auto: Standardizes the Gateway MAC across the switch fabric.
- ip/mac duplication limit 20 time 10: Prevents a loop from flapping your BGP table.
- default-gateway advertise: Proactively seeds the ARP tables of all VTEPs to reduce "silent host" latency.

1. Capability Negotiation (Receive vs. Send)

- receive: Tells neighbor of capability of storing multiple paths for the same prefix in BGP table.
- send: Tells the neighbor a list of all valid paths.

2. Path Selection Strategy (Select)

- select all: Sends every single valid path it knows.
- select best-range [N]: Only sends paths that are "close" to being the best (e.g., within a certain metric or AS-PATH length).
- select backup: Specifically sends a pre-calculated backup path for fast-reroute.
- select group-best: In complex designs, sends the best path from each neighboring AS.

3. Scalable Architecture (The "Transit VRF777")

- Concept: A dedicated VRF for external connectivity (Border/Transit).

  - Decouples Routing Tables: Prevents external routing tables from bloating every leaf node. Only the Border Leaf handles the massive external routes; the internal VTEPs only see what they need.
  - Reduces Control Plane Stress: By summarizing routes in the Transit VRF before redistributing them into EVPN, you minimize the number of BGP updates that need to be processed by every switch in the fabric.
  - Centralized On-Ramp: It provides a single point for route aggregation, making it easier to manage.
 
