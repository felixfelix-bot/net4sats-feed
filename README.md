# ARCHIVED — superseded by net4sats/installer

This repository is retired as part of the net4sats thin-shell consolidation. It is kept
for history only; **nothing here is maintained, and two of its published entry points no
longer work**:

- `https://net4sats.com/install.sh` — **404** (the domain does not serve the installer)
- `https://blossom.net4sats.com/feed/net4sats` — **NXDOMAIN** (the feed host does not
  resolve; this was the origin in this repo's `README.md` and `install-net4sats.sh`)

The host is deliberately **not** resurrected. The package feed it served is replaced by
upstream releases, which publish per-arch `apk` **and** `ipk` for eight targets
(`FreedomTechFeed/packages` `v0.6.0-rc6`: 16 `tollgate-wrt` artifacts), so `opkg` on
OpenWrt 24.10 and `apk` on 25.12+ are both served by upstream.

## The working install path today

```sh
curl -fsSL https://raw.githubusercontent.com/net4sats/installer/main/install.sh \
  | N4S_REPO_SLUG=net4sats/installer sh
```

Branded portal rendering = upstream `OpenTollGate/tollgate-captive-portal-site` plus the
`portal-skin/` overlay in `net4sats/installer` (descriptor + logos as inputs; zero
app-logic diff).

## History

History is preserved as-is — external repos pin SHAs here (`physical-router-test-automation`
pins this repo). Archive-only; never rewritten.
