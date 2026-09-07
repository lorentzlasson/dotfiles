# set up tailscale

Mesh VPN across all machines (xps15, xps13, asus, nuc) so the server is
reachable from anywhere without port forwarding.

- Enable `services.tailscale` in the base config so every machine joins.
- Run `tailscale up` once per machine to authenticate.
- Consider making nuc an exit node / subnet router for the home LAN.
- Revisit whether nginx services on nuc should bind to the tailnet only.
