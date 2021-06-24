#!/bin/sh
set -e
export CRIO_VERSION=1.21
export OS=CentOS_8
export K8S_VERSION=1.21.0
export IPADDR=$(ip a show eth0 | grep inet | grep -v inet6 | awk '{print $2}' | cut -f1 -d/)
export CLUSTER_NAME="k8scluster.training.home"

##
modprobe overlay
modprobe br_netfilter

mkdir -
cat > /etc/modules-load.d/crio.conf <<EOF
overlay
br_netfilter
EOF

#firewall-cmd --add-masquerade --permanent
#firewall-cmd --reload
systemctl stop firewalld
systemctl disable firewalld

cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sysctl --system

curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable.repo https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/devel:kubic:libcontainers:stable.repo
curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.repo
dnf install -y --nogpgcheck cri-o

systemctl daemon-reload
systemctl start crio
systemctl enable crio

mkdir -p /etc/crio/crio.conf.d
cat <<EOF | tee /etc/crio/crio.conf.d/02-cgroup-manager.conf
[crio.runtime]
conmon_cgroup = "pod"
cgroup_manager = "cgroupfs"
EOF
systemctl restart crio