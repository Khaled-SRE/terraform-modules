output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = try(aws_eks_cluster.eks_cluster.certificate_authority, null)
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = try(aws_eks_cluster.eks_cluster.endpoint, null)
}

output "eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}
output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "eks_alb_role_arn" {
  value = aws_iam_role.load_balancer_controller_role.arn
}

output "eks_efs_role_arn" {
  value = aws_iam_role.efs_csi_driver_role.arn
}

output "eks_security_group_id" {
  description = "(Deprecated) ID of the optionally created additional Security Group for the EKS cluster"
  value       = one(aws_eks_cluster.eks_cluster[*].vpc_config[0].cluster_security_group_id)
}

output "eks_oidc_url" {
  value = aws_iam_openid_connect_provider.oidc.url
}

output "eks_oidc_arn" {
  value = aws_iam_openid_connect_provider.oidc.arn
}

output "vpc_cni_addon_version" {
  value = data.aws_eks_addon_version.vpc_cni.version
}

output "kube_proxy_addon_version" {
  value = data.aws_eks_addon_version.kube_proxy.version
}

output "core_dns_addon_version" {
  value = data.aws_eks_addon_version.core_dns.version
}