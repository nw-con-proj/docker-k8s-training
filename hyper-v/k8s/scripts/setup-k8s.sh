#!/bin/sh
set -e

##
export CRIO_VERSION=1.21
export OS=CentOS_8
export K8S_VERSION=1.21.0
export IPADDR=$(ip a show eth0 | grep inet | grep -v inet6 | awk '{print $2}' | cut -f1 -d/)
export CLUSTER_NAME="k8scluster.training.home"

##
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sysctl --system

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

dnf install -y kubelet-$K8S_VERSION kubeadm-$K8S_VERSION kubectl-$K8S_VERSION --disableexcludes=kubernetes
dnf install -y bash-completion
echo "source <(kubectl completion bash)" >> ~/.bashrc 

systemctl enable --now kubelet 
systemctl restart kubelet

