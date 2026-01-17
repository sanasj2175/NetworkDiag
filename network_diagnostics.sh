#!/bin/bash

echo "=============================="
echo " Network Diagnostics Report"
echo "=============================="
echo   #prints blank line

# 1. Active Network Interface & IP
#show ip4 addresses | text processor matches inet lines then check second col doesnt match 127 ip which is loopback then print last column
echo "1️⃣ Network Interface & IP Address:"
ip -4 addr show | awk '/inet/ && $2 !~ /^127/ {print "Interface:", $NF, "| IP:", $2}'
echo

# 2. Default Gateway
#print default IP and interface
echo "2️⃣ Default Gateway:"
ip route | awk '/default/ {print "Gateway:", $3, "| Interface:", $5}'
echo

# 3. Internet Connectivity Test
echo "3️⃣ Internet Connectivity Test (8.8.8.8):"
if ping -c 2 8.8.8.8 >/dev/null 2>&1; then #2pkts send >redirect output /dev/null discard 2>&1 discard errors
    echo "✅ Internet reachable"
else
    echo "❌ Internet NOT reachable"
fi
echo

# 4. DNS Resolution Test
echo "4️⃣ DNS Resolution Test:"
if ping -c 1 google.com >/dev/null 2>&1; then #checks resolve domain names
    echo "✅ DNS working"
else
    echo "❌ DNS resolution failed"
fi
echo

# 5. Listening Services (Ports)
echo "5️⃣ Listening TCP/UDP Ports:"
ss -tuln
echo

# 6. Final Summary
echo "=============================="
echo " Network diagnostics complete"
echo "=============================="
