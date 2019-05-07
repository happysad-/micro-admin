#!/bin/bash

IP4_FIREWALL=/sbin/iptables
IP6_FIREWALL=/sbin/ip6tables
LSPCI=/usr/bin/lspci
ROUTE=/sbin/route
NETSTAT=/bin/netstat
LSB=/usr/bin/lsb_release

OUTPUT_FILE="network.$(hostname -f).$(date + '%d-%m-%y').log"

check_root() {
    local meid=$(id -u)

    if [ $meid -ne 0 ]; then
        echo "[ERR]: Need to run as root!"
    fi
}
