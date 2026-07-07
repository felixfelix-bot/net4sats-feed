#!/bin/bash
set -euo pipefail

# Build net4sats meta-package ipk (Architecture: all — no compilation needed)
# Usage: ./build-ipk.sh [version]
# Creates net4sats_<version>_all.ipk in the repo root.

VERSION="${1:-0.1.0}"
ARCH="all"
PACKAGE_NAME="net4sats"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT

echo "=== Building $PACKAGE_NAME ipk ==="
echo "  Architecture: $ARCH"
echo "  Version:      $VERSION"

CTRL_DIR="$WORK_DIR/control"
DATA_DIR="$WORK_DIR/data"

mkdir -p "$CTRL_DIR" "$DATA_DIR"

# Install uci-defaults
mkdir -p "$DATA_DIR/etc/uci-defaults"
for f in "$SCRIPT_DIR/files/etc/uci-defaults/"*; do
  [ -f "$f" ] || continue
  cp "$f" "$DATA_DIR/etc/uci-defaults/"
  chmod 755 "$DATA_DIR/etc/uci-defaults/$(basename "$f")"
done

# Control file
cat > "$CTRL_DIR/control" << EOF
Package: $PACKAGE_NAME
Version: ${VERSION}
Architecture: ${ARCH}
Maintainer: net4sats <dev@net4sats.com>
License: MIT
Depends: tollgate-wrt, configurationwizzard, nodogsplash
Description: net4sats meta-package. One-command router setup.
 Installs tollgate-wrt backend, configurationwizzard admin UI + captive portal,
 and nodogsplash WiFi gateway.
EOF

cd "$WORK_DIR"
tar -czf control.tar.gz -C "$CTRL_DIR" .
tar -czf data.tar.gz -C "$DATA_DIR" .
echo "2.0" > debian-binary

OUTPUT="$SCRIPT_DIR/${PACKAGE_NAME}_${VERSION}_${ARCH}.ipk"
# Standard ar archive for opkg
ar -rcs "$OUTPUT" debian-binary control.tar.gz data.tar.gz 2>/dev/null || {
  # Fallback: just tar the components (for systems without ar)
  cat debian-binary control.tar.gz data.tar.gz > "$OUTPUT"
}

echo "=== Built: $OUTPUT ==="
ls -lh "$OUTPUT"
