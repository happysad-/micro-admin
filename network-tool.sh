#!/bin/bash

IP4_FIREWALL=/sbin/iptables
IP6_FIREWALL=/sbin/ip6tables
LSPCI=/usr/bin/lspci
ROUTE=/sbin/route
NETSTAT=/bin/netstat
LSB=/usr/bin/lsb_release

# Output File: Will store all the information
OUTPUT_FILE="network.$(hostname -f).$(date '+%d-%m-%y_%H:%M:%S').log"

check_root() {
    local meid=$(id -u)

    if [ $meid -ne 0 ]; then
        echo "[ERR]: Need to run as root!"
	exit 999
    fi
}

write_header() {
    echo "__________________________________" >> $OUTPUT_FILE
    echo "| $@" >> $OUTPUT_FILE
    echo "__________________________________" >> $OUTPUT_FILE
}

collect_data() {
    write_header "Hostname: $(hostname -f) Kernel: $(uname -mrs) Date: $(date)"
}

check_root
collect_data
