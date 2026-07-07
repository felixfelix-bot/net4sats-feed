# net4sats-feed

OpenWrt package feed for net4sats. One command to turn any supported router into a net4sats hotspot.

## Quick Install

```bash
# On your OpenWrt router:
curl -sL https://net4sats.com/install.sh | sh
```

Or add the feed manually and install:

```bash
# apk (OpenWrt 25.12+)
echo "https://blossom.net4sats.com/feed/net4sats" >> /etc/apk/repositories
apk update && apk add net4sats

# opkg (OpenWrt 24.10)
echo "src/gz net4sats https://blossom.net4sats.com/feed/net4sats" >> /etc/opkg/customfeeds.conf
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
