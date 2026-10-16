> ## ⚠️ SUPERSEDED — use `net4sats/installer`
>
> This repository (the net4sats **feed**) has been superseded. TollGate packages are now
> published by the upstream feed, and the net4sats install path is a thin branded shell
> that hands off to the upstream installer:
>
> ```sh
> git clone https://github.com/net4sats/installer
> cd installer && sh install.sh
> ```
>
> The feed origin this repo referenced (`blossom.net4sats.com`) is **NXDOMAIN** and has
> been removed below rather than resurrected. The host `net4sats.com/install.sh` also
> **404s**; the working path is the repo above.
>
> This repo is retained for reference and will be archived.

# net4sats-feed

OpenWrt package feed for net4sats. One command to turn any supported router into a net4sats hotspot.

## Quick Install

```bash
# On your OpenWrt router:
git clone https://github.com/net4sats/installer && cd installer && sh install.sh
```

Or add the feed manually and install:

```bash
# apk (OpenWrt 25.12+)
echo "<SUPERSEDED — see the banner above; use the upstream feed>" >> /etc/apk/repositories
apk update && apk add net4sats

# opkg (OpenWrt 24.10)
echo "<SUPERSEDED — see the banner above; use the upstream feed>" >> /etc/opkg/customfeeds.conf
opkg update && opkg install net4sats
```

## Packages

| Package | Description | Source |
|---------|-------------|--------|
| `net4sats` | Meta-package — installs everything below | This repo |
| `configurationwizzard` | Admin UI + captive portal | net4sats/configurationwizzard |
| `tollgate-wrt` | Payment backend | OpenTollGate/tollgate-wrt |
| `nodogsplash` | WiFi gateway | OpenWrt packages |

## What You Get

- **Admin UI** on port 8090 — configure your router, Lightning address, split
- **Captive portal** — pay-per-use WiFi via Lightning
- **Payment backend** — handles invoices, routing, mints

## Supported Routers

- GL-MT6000 (Flint 2)
- GL-MT3000 (Beryl AX)
- CF-WR632AX
- Any OpenWrt 24.10+ with sufficient flash

## Build

```bash
# Using the OpenWrt SDK:
make -C $(TOPDIR) package/net4sats/{clean,compile} V=s
```
