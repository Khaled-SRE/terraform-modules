# Terraform Modules for AWS Infrastructure 🚀

A collection of **modular**, **reusable**, and **production-ready** Terraform modules to provision and manage infrastructure on AWS.

---

## 📦 Overview

This repository provides a library of composable Terraform modules designed to enforce consistency, scalability, and security across AWS environments. Each module is purpose-built to support modern cloud infrastructure with minimal effort and high configurability.

---

## 🧱 Available Modules

### 🔹 [Network / VPC]
- Provision highly available and secure VPCs.
- Supports public and private subnet configurations.
- Includes Internet Gateway (IGW) and NAT Gateway setups.
- Route table management for private and public subnets.

**Key Features:**
- CIDR block customization
- Multi-AZ subnet support
- NAT Gateway with Elastic IPs
- Private subnet internet access via NAT
- DNS support & hostnames enabled

---

### 🔹 [EKS (Elastic Kubernetes Service)]
- Deploy fully-managed EKS clusters.

**Key Features:**
- Configurable Kubernetes version
- Public/Private endpoint access
- Managed add-ons support (CoreDNS, KubeProxy, VPC CNI)
- Integrated IAM roles

---

### 🔹 [EKS Node Groups]
- Launch and manage EKS managed node groups.

**Key Features:**
- Custom AMI and instance types
- Auto-scaling configuration
- Launch templates support
- Taints and labels configuration

---

### 🔹 [EKS Add-ons]
- Plug-and-play extensions for EKS clusters.

**Included Add-ons:**
- [ALB Ingress Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/)
- [Argo CD](https://argo-cd.readthedocs.io/)
- [External DNS](https://github.com/kubernetes-sigs/external-dns)

---

### 🔹 [ECR (Elastic Container Registry)]
- Create and configure secure and policy-driven ECR repositories.

**Key Features:**
- Image tag mutability
- Automatic image scanning
- AES256 encryption support
- Lifecycle policy rules to clean up old images

---

### 🔹 [Route53 DNS]
- Configure hosted zones and DNS records.

**Key Features:**
- Public and private zones
- A, CNAME, TXT record support
- Zone delegation support

---

### 🔹 [Security Groups]
- Create reusable and customizable security groups.

**Key Features:**
- Ingress/egress rule templates
- Application-specific security group presets
- Cross-module referencing

---

## ✅ Requirements

- **Terraform:** `v1.0+`
- **AWS Provider:** `v4.0+`
- AWS CLI configured with appropriate IAM permissions

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Khaled-SRE/terraform-modules.git
   ```
   
2. Add a module to your root configuration:
   ```bash
    module "vpc" {
      source = "./terraform-modules/network/vpc"
    
      vpc_cidr = "10.0.0.0/16"
      ...
    }
   ```

3. Initialize and apply:
   ```bash
    terraform init
    terraform apply
   ```
