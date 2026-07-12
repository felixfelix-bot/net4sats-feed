PKG_MAKEFILE_DIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(TOPDIR)/rules.mk

PKG_NAME:=net4sats

DISPLAY_VERSION:=$(if $(strip $(PACKAGE_VERSION)),$(PACKAGE_VERSION),0.1.0-beta2)
ifeq ($(CONFIG_USE_APK),y)
PKG_VERSION:=$(shell sh "$(PKG_MAKEFILE_DIR)normalize-apk-version.sh" "$(DISPLAY_VERSION)")
else
PKG_VERSION:=$(DISPLAY_VERSION)
PKG_RELEASE:=1
endif

PKG_MAINTAINER:=net4sats <dev@net4sats.com>
PKG_LICENSE:=MIT
PKG_FLAGS:=overwrite

include $(INCLUDE_DIR)/package.mk

define Package/net4sats
  SECTION:=net
  CATEGORY:=Network
  TITLE:=net4sats — one-command router setup
  DEPENDS:=+tollgate-wrt +configurationwizzard +nodogsplash
  PKGARCH:=all
endef

define Package/net4sats/description
  net4sats meta-package. Installs everything needed to run a net4sats
  router: tollgate-wrt backend, configurationwizzard admin UI + captive
  portal, and nodogsplash WiFi gateway.
  One command: apk add net4sats
endef

define Build/Compile
endef

define Package/net4sats/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) $(PKG_MAKEFILE_DIR)files/etc/uci-defaults/95-net4sats-feed $(1)/etc/uci-defaults/95-net4sats-feed
	$(INSTALL_BIN) $(PKG_MAKEFILE_DIR)files/etc/uci-defaults/96-net4sats-uhttpd $(1)/etc/uci-defaults/96-net4sats-uhttpd
	$(INSTALL_BIN) $(PKG_MAKEFILE_DIR)files/etc/uci-defaults/97-net4sats-nodogsplash $(1)/etc/uci-defaults/97-net4sats-nodogsplash
endef

$(eval $(call BuildPackage,net4sats))
