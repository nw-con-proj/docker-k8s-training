#!/bin/sh
set -e

# set timezone
timedatectl set-timezone Asia/Tokyo

# restart ntp
systemctl restart chronyd
systemctl enable chronyd

# selinux
setenforce 0 
sed -i -e "s/^SELINUX=enforcing$/SELINUX=disabled/g" /etc/selinux/config

# swap off
swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab
chmod +x /etc/rc.d/rc.local
sed -i '$ a swapoff -a' /etc/rc.d/rc.local

