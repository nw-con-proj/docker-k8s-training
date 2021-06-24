#!/bin/sh
set -e

nmcli connection modify eth0 ipv4.method manual ipv4.addresses 192.168.0.10/24 ipv4.gateway 192.168.0.1 connection.autoconnect yes
reboot
