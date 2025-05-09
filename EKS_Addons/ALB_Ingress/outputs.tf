output "helm_release_name" {
  description = "The name of the Helm release"
  value       = helm_release.aws_load_balancer_controller.name
}

output "helm_release_version" {
  description = "The version of the Helm release"
  value       = helm_release.aws_load_balancer_controller.version
}

output "helm_release_status" {
  description = "The status of the Helm release"
  value       = helm_release.aws_load_balancer_controller.status
}

output "namespace" {
  description = "The namespace where the AWS Load Balancer Controller is installed"
  value       = "kube-system"
}

output "service_account_name" {
  description = "The name of the service account used by the AWS Load Balancer Controller"
  value       = kubernetes_service_account.aws_load_balancer_controller.metadata[0].name
}