#!/bin/bash

IP4_FIREWALL=/sbin/iptables
IP6_FIREWALL=/sbin/ip6tables
LSPCI=/usr/bin/lspci
ROUTE=/sbin/route # <- TODO: Check dependencies, install if req.
NETSTAT=/bin/netstat # <- TODO: Check dependencies
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

setup() {
    touch $OUTPUT_FILE
}

write_header() {
    echo "__________________________________" >> $OUTPUT_FILE
    echo "| $@" >> $OUTPUT_FILE
    echo "__________________________________" >> $OUTPUT_FILE
}

collect_data() {
    write_header "Hostname: $(hostname -f) Kernel: $(uname -mrs) Date: $(date)"
    
    write_header "LSB"
    ${LSB} -a >> $OUTPUT_FILE

    write_header "PCI Devices"
    ${LSPCI} -v >> $OUTPUT_FILE

    write_header "Routing Table"
    ${ROUTE} -n >> $OUTPUT_FILE

    write_header "IP4 Firewall Configuration"
    ${IP4_FIREWALL} -L -n >> $OUTPUT_FILE

    write_header "IP6 Firewall Configuration"
    ${IP6_FIREWALL} -L -n >> $OUTPUT_FILE

    write_header "Network Stats"
    ${NETSTAT} -s >> $OUTPUT_FILE
}

setup
check_root
collect_data
