#!/bin/sh

set -e
##
export VERSION=1.20.0
export OS=CentOS_8
export IPADDR=$(ip a show eth0 | grep inet | grep -v inet6 | awk '{print $2}' | cut -f1 -d/)

swapoff -a

kubeadm config images pull

cat <<EOF | tee ~/kubeadm-config.yaml
# kubeadm-config.yaml
kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1beta2
kubernetesVersion: v${VERSION}
clusterName: democluster
networking:  
  podSubnet: 10.244.0.0/16
---
apiVersion: kubeadm.k8s.io/v1beta2
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: ${IPADDR}
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: cgroupfs
EOF
 
kubeadm init --config ~/kubeadm-config.yaml | tee kubeadm-init.out

mkdir -p /root/.kube
sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config

mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown vagrant:vagrant /home/vagrant/.kube/config

echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

cat <<EOF | tee /vagrant/join-worker.sh
#!/bin/bash
sudo $(kubeadm token create --print-join-command)
EOF
chmod +x /vagrant/join-worker.sh 

