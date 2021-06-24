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

# package install  
dnf install -y git 
