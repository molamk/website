---
title: "How to Set Up Gcloud and Kubectl"
date: 2019-03-03T20:28:25-05:00
draft: false
---

# Install `google-cloud-sdk`

```bash
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

# Initialize `gcloud`

- Run `gcloud init`
- Log in
- Choose or create a new project
- Choose a _compute zone_

# Enable APIs on Google Cloud

- Enable Billing
- Cloud Build
- Compute Engine
- Kubernetes Engine

# Install `kubectl`

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

# Provision the cluster

## Configure the compute zone

```bash
gcloud config set compute/zone us-east1-d
```

## Create the Jenkins cluster

```bash
gcloud container clusters create jenkins-cd \
  --machine-type n1-standard-2 --num-nodes 2 \
  --scopes "https://www.googleapis.com/auth/projecthosting,cloud-platform"
```

## Verify that the cluster is running

```bash
gcloud container clusters list

# Output
NAME        LOCATION    MASTER_VERSION  MASTER_IP    MACHINE_TYPE   NODE_VERSION  NUM_NODES  STATUS
jenkins-cd  us-east1-d  1.9.7-gke.3     35.231.8.57  n1-standard-2  1.9.7-gke.3   2          RUNNING
```

## Update the `kubectl` context

```bash
gcloud container clusters get-credentials my-cluster
```

## Confirm that we can connect to the cluster

```bash
kubectl cluster-info

# Output
Kubernetes master is running at https://130.211.178.38
GLBCDefaultBackend is running at https://130.211.178.38/api/v1/proxy/namespaces/kube-system/services/default-http-backend
Heapster is running at https://130.211.178.38/api/v1/proxy/namespaces/kube-system/services/heapster
KubeDNS is running at https://130.211.178.38/api/v1/proxy/namespaces/kube-system/services/kube-dns
kubernetes-dashboard is running at https://130.211.178.38/api/v1/proxy/namespaces/kube-system/services/kubernetes-dashboard
```

# Set-up Helm

## Configure cluster administrator

```bash
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin \
        --user=$(gcloud config get-value account)
```

## Grant `Tiller` the `cluster-admin` role

```bash
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-admin-binding --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller
```

## Install Helm

```bash
sudo snap install helm --classic
```

## Initialize Helm

```bash
./helm init --service-account=tiller
./helm repo update
./helm version

# Output
Client: &version.Version{SemVer:"v2.9.1", GitCommit:"20adb27c7c5868466912eebdf6664e7390ebe710", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.9.1", GitCommit:"20adb27c7c5868466912eebdf6664e7390ebe710", GitTreeState:"clean"}
```

# References

- [Cloud SDK - Quickstart for Debian and Ubuntu](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu)
- [GCP - Setting up Jenkins on Kubernetes Engine](https://cloud.google.com/solutions/jenkins-on-kubernetes-engine-tutorial)
- [gcloud CLI overview](https://cloud.google.com/sdk/gcloud/)