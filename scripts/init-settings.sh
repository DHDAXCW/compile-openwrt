#!/bin/bash
#=================================================
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci set dhcp.wan6=dhcp
uci set dhcp.wan6.interface=wan
uci set dhcp.wan6.ra=hybrid
uci set dhcp.wan6.dhcpv6=hybrid
uci set dhcp.wan6.ndp=hybrid
uci set dhcp.wan6.master=1
uci set network.lan.dns='127.0.0.1'
uci set uhttpd.main.redirect_https='1'
uci set uhttpd.main.rfc1918_filter='0'
uci set dhcp.lan.force='1'
uci set "fstab.@global[0].check_fs=1"
uci set "fstab.@global[0].anon_mount=1"
uci commit
uci set "dhcp.@dnsmasq[0].filter_aaaa=1"
uci commit
sed -i 's/^[^#].*option ula/#&/' /etc/config/network
uci set dockerd.globals.registry_mirrors='https://hub-mirror.c.163.com'
# Disable opkg signature check
# sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf

# Disable autostart by default for some packages
cd /etc/rc.d
rm -f S98udptools || true
rm -f S99nft-qos || true

# Try to execute init.sh (if exists)

if [ ! -f "/boot/init.sh" ]; then
bash /boot/init.sh
fi

exit 0
