#!/usr/bin/env bash

#iptables -X
#iptables -F
#iptables -t nat -X
#iptables -t nat -F

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -L -n -v
iptables -t nat -L -n -v
