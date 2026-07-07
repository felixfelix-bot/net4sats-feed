#!/bin/sh
# install-net4sats.sh — Bootstrap net4sats on any OpenWrt router
# Usage: curl -sL https://net4sats.com/install.sh | sh
#
# Downloads the net4sats meta-package and all dependencies,
# then configures the router. Idempotent.

set -e

NET4SATS_FEED="https://blossom.net4sats.com/feed/net4sats"
PACKAGE="net4sats"

echo "net4sats — Installing on OpenWrt..."
echo ""

# Detect package manager
if command -v apk >/dev/null 2>&1; then
  PKG_MGR="apk"
  # Add feed if not present
  if ! grep -qF "$NET4SATS_FEED" /etc/apk/repositories 2>/dev/null; then
    echo "$NET4SATS_FEED" >> /etc/apk/repositories
    echo "Added net4sats feed"
  fi
  apk update
  apk add $PACKAGE
elif command -v opkg >/dev/null 2>&1; then
  PKG_MGR="opkg"
  if ! grep -qF "net4sats" /etc/opkg/customfeeds.conf 2>/dev/null; then
    echo "src/gz net4sats $NET4SATS_FEED" >> /etc/opkg/customfeeds.conf
    echo "Added net4sats feed"
  fi
  opkg update
  opkg install $PACKAGE
else
  echo "ERROR: No supported package manager found (apk/opkg)"
  exit 1
fi

echo ""
echo "net4sats installed successfully!"
echo "Admin UI: http://net4sats.lan:8090"
echo "Captive portal: http://net4sats.lan"
echo ""
echo "After reboot, configure your WiFi and Lightning address at the admin UI."
