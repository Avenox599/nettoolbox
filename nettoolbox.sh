#!/bin/bash

# ===========================================
#           Network Diagnostic Tool
# ===========================================

# 1. Retrieving the active network interface, IP address, and gateway

INTERFACE=$(ip route show default | awk '{print $5}')
MY_IP=$(ip -o -4 addr show dev "$INTERFACE" | awk '{print $4}')
MY_GATEWAY=$(ip route show default | awk '/default/ {print $3}')

if [[ -z "$INTERFACE" ]]; then
    echo "No active network interface found."
    exit 1
fi

echo "========================================"
echo "          DIAGNOSTIC NETTOOLBOX         "
echo "========================================"

echo "Active interface  : $INTERFACE"
echo "Adresse IP/CIDR  : ${MY_IP:-No found}"
echo "Gateway           : ${MY_GATEWAY:-No found}"
echo "-----------------------------------------"

# 2. Test 1: IP Connectivity (IP/Internet Layer Test)
echo -n "[1/3] Test d'accès Internet (8.8.8.8)"
if ping -c 2 -W 2 8.8.8.8 > /dev/null 2>&1; then
    echo -e "\nOK"
else
    echo "Fail (Check your gateway or global connection)"
    exit 1
fi

# 3. Test 2: DNS Resolution (Application/DNS Layer Test)
echo -n "[2/3] Test of DNS service (google.com) ..."
if ping -c 2 -W 2 google.com > /dev/null 2>&1; then
    echo -e "\nOK"
else
    echo "Fail (IP connection works, but DNS not respond)"
    exit 1
fi

# 4. Test 3: DNS information
echo -e "\n[3/3] DNS resolution information :"
echo "_______________________________________"
dig +short google.com | awk '{print "Adresse IP found for google.com : "$0}'



