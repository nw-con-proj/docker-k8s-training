# Docker / Kubernetesを触ってみよう  

DockerやKubernetesを実際に触ってみるための環境構築とハンズオンの手順です。
環境は Vagrant + VirtualBox で構成しています。  

## 稼働環境
下記の環境でこの手順を作成しています。  

|||
|:--|:--|
|OS|Windows 10|
|CPU|12Core|
|mem|32GB|
|Disk|100GB|
|VirtualBox| version 6.1.20 r143896|
|Vagrant| version 2.2.16|

> Azure Labsで稼働可能です  

### Vagrantにて構成できる環境  

- Docker ハンズオン環境
- Kubernetes ハンズオン環境  

#### Docker ハンズオン環境
|||
|:--|:--|
|台数|1|
|OS|AlmaLinux release 8.4 (Electric Cheetah)|
|CPU|4Core|
|mem|4GB|
|Disk|20GB|

#### Kubernetes ハンズオン環境
|||
|:--|:--|
|役割|Master Node|
|台数|1|
|OS|AlmaLinux release 8.4 (Electric Cheetah)|
|CPU|4Core|
|mem|4GB|
|Disk|20GB|

|||
|:--|:--|
|役割|Worker Node|
|台数|3|
|OS|AlmaLinux release 8.4 (Electric Cheetah)|
|CPU|4Core|
|mem|4GB|
|Disk|20GB|


## ハンズオン  
ハンズオン内容はまだ触ったことのない人向けです。  
座学はありませんのでWeb上にある素敵な資料をご確認ください。最低限[このあたり](https://www.slideshare.net/KoheiTokunaga/ss-122754942)を読んでおくとわかりやすいと思います。

DockerやKubernetesを動かす環境がない人向けにAzure Lab Serviceを利用しハンズオンをしていただくことも可能です。  

環境のBootupからハンズオンまでを含めた手順はそれぞれ下記をご確認ください。  


## Ex.

- VirtualBox  
  - Oracle社製のVMware WorkStation みたいなものです。クライアントPC上でVMを作成できます。
- Vagrant
  - HashiCorp社製の違う環境に移行可能な開発環境を簡単に構築・管理し、配布することができる開発環境作成ツールです。
  - Vagrantを使ってVirtualBox上にVMをデプロイします。  




