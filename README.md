# Terraform Modules for AWS Infrastructure 🚀

A collection of **modular**, **reusable**, and **production-ready** Terraform modules to provision and manage infrastructure on AWS.

---

## 📦 Overview

This repository provides a library of composable Terraform modules designed to enforce consistency, scalability, and security across AWS environments. Each module is purpose-built to support modern cloud infrastructure with minimal effort and high configurability.

---

## 🧱 Available Modules

### 🔹 Network / VPC
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

**Example:**
```hcl
module "vpc" {
  source   = "./Network/VPC"
  vpc_cidr = "10.0.0.0/16"
  # ...
}
```

---

### 🔹 EKS (Elastic Kubernetes Service)
- Deploy fully-managed EKS clusters.

**Key Features:**
- Configurable Kubernetes version
- Public/Private endpoint access
- Managed add-ons support (CoreDNS, KubeProxy, VPC CNI)
- Integrated IAM roles

**Example:**
```hcl
module "eks" {
  source        = "./EKS"
  cluster_name  = "my-eks-cluster"
  # ...
}
```

---

### 🔹 EKS Node Groups
- Launch and manage EKS managed node groups.

**Key Features:**
- Custom AMI and instance types
- Auto-scaling configuration
- Launch templates support
- Taints and labels configuration
- Optional VPC-wide traffic allowance

**Example:**
```hcl
module "eks_nodegroup" {
  source                = "./EKS_Nodegroup"
  cluster_name          = module.eks.cluster_name
  node_group_name       = "general"
  node_group_subnets    = module.vpc.private_subnet_ids
  vpc_id                = module.vpc.vpc_id
  eks_security_group_id = module.eks.eks_security_group_id
  # Optional:
  vpc_cidr_blocks       = module.vpc.vpc_cidr_blocks
  allow_vpc_traffic     = true
  # ...
}
```

---

### 🔹 EKS Add-ons
Plug-and-play extensions for EKS clusters.

**Included Add-ons:**
- **ALB Ingress Controller**: Ingress for Kubernetes using AWS ALB.
- **Argo CD**: GitOps continuous delivery for Kubernetes.
- **External DNS**: Manage Route53 DNS records dynamically.
- **StorageClass**: Default storage class for EKS.
- **EFS CSI Driver**: Mount EFS volumes in Kubernetes pods.

**Example (ALB Ingress):**
```hcl
module "alb_ingress" {
  source              = "./EKS_Addons/ALB_Ingress"
  cluster_name        = module.eks.cluster_name
  eks_alb_role_arn    = module.eks.eks_alb_role_arn
  private_subnet_ids  = module.vpc.private_subnet_ids
  # ...
}
```

**Example (Argo CD):**
```hcl
module "argocd" {
  source              = "./EKS_Addons/Argo_Cd"
  chart_version       = "5.46.7"
  certificate_arn     = module.acm.certificate_arn
  argocd_domain_name  = "argocd.example.com"
  subnet_ids          = module.vpc.public_subnet_ids
  security_group_ids  = [module.security_group.alb_sg_id]
  # ...
}
```

---

### 🔹 ECR (Elastic Container Registry)
- Create and configure secure and policy-driven ECR repositories.

**Key Features:**
- Image tag mutability
- Automatic image scanning
- AES256 encryption support
- Lifecycle policy rules to clean up old images

**Example:**
```hcl
module "ecr" {
  source   = "./ECR"
  ecr_name = "my-app"
  tags     = { Environment = "dev" }
}
```

---

### 🔹 Route53 DNS
- Configure hosted zones and DNS records.

**Key Features:**
- Public and private zones
- A, CNAME, TXT record support
- Zone delegation support

**Example:**
```hcl
module "route53" {
  source = "./Route53"
  domain = "example.com"
  private_zone = false
  # ...
}
```

---

### 🔹 Security Groups
- Create reusable and customizable security groups.

**Key Features:**
- Ingress/egress rule templates
- Application-specific security group presets
- Cross-module referencing

**Example:**
```hcl
module "security_group" {
  source = "./Security_Group"
  # ...
}
```

---

### 🔹 ACM (Certificate Manager)
- Provision and validate ACM certificates for use with ALB, CloudFront, etc.

**Key Features:**
- DNS validation via Route53
- Wildcard and SAN support
- Tagging support

**Example:**
```hcl
module "acm" {
  source  = "./ACM"
  domain  = "*.example.com"
  zone_id = module.route53.zone_id
  # ...
}
```

---

### 🔹 WAF (Web Application Firewall)
- Create and manage AWS WAFv2 Web ACLs and rules.

**Key Features:**
- Managed rule groups
- Custom rules
- ALB/CloudFront association

**Example:**
```hcl
module "waf" {
  source = "./WAF"
  # ...
}
```

---

### 🔹 Secret Manager
- Manage secrets securely with AWS Secrets Manager.

**Key Features:**
- Create and rotate secrets
- Tagging support

**Example:**
```hcl
module "secret_manager" {
  source      = "./Secret_Manager"
  secret_name = "db-password"
  secret_value = "supersecret"
  # ...
}
```

---

### 🔹 StorageClass & EFS CSI Driver
- Default storage class and EFS integration for EKS.

**Example:**
```hcl
module "storage_class" {
  source = "./EKS_Addons/StorageClass"
}

module "efs_csi_driver" {
  source = "./EKS_Addons/EFS_CSI_Driver"
  # ...
}
```

---

## 🔗 Module Composition & Best Practices

- **Outputs:** Each module exports useful outputs (IDs, ARNs, endpoints, etc.) for cross-module referencing.
- **Composition:** Wire modules together by passing outputs as inputs (e.g., VPC IDs, subnet IDs, security group IDs).
- **EKS Addons:** Deploy EKS, then node groups, then addons (ALB Ingress, ArgoCD, etc.).
- **Security:** Use least-privilege IAM roles and restrict security group rules as much as possible.
- **Tagging:** Use tags for cost allocation and resource tracking.
- **Lifecycle:** Use lifecycle policies for ECR and WAF for security.

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
   ```hcl
   module "vpc" {
     source = "./Network/VPC"
     vpc_cidr = "10.0.0.0/16"
     # ...
   }
   ```

3. Initialize and apply:
   ```bash
   terraform init
   terraform apply
   ```
