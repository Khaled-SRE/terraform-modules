resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks_alb_role_arn
    }
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = var.chart_version

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_load_balancer_controller.metadata[0].name
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.${var.aws_region}.amazonaws.com/amazon/aws-load-balancer-controller"
  }

  set {
    name  = "replicaCount"
    value = var.replica_count
  }

  set {
    name  = "resources.requests.cpu"
    value = var.resources_requests_cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.resources_requests_memory
  }

  set {
    name  = "resources.limits.cpu"
    value = var.resources_limits_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.resources_limits_memory
  }

  # Security and ALB settings
  set {
    name  = "enableShield"
    value = "true"
  }

  set {
    name  = "enableWafv2"
    value = "true"
  }

  set {
    name  = "defaultTargetType"
    value = "ip"
  }

  set {
    name  = "ingressClass"
    value = "alb"
  }

  set {
    name  = "ingressClassDefault"
    value = "true"
  }

  # Public subnet configuration
  set {
    name  = "subnets.public"
    value = "{${join(",", var.public_subnet_ids)}}"
  }

  # Security group settings
  set {
    name  = "securityGroup.create"
    value = "true"
  }

  set {
    name  = "securityGroup.name"
    value = "${var.cluster_name}-alb-sg"
  }

  # ALB security settings
  set {
    name  = "loadBalancerAttributes.routing.http.drop_invalid_header_fields.enabled"
    value = "true"
  }

  set {
    name  = "loadBalancerAttributes.routing.http.x_amzn_tls_version_and_cipher_suite.enabled"
    value = "true"
  }

  set {
    name  = "loadBalancerAttributes.routing.http.xff_client_port.enabled"
    value = "true"
  }

  set {
    name  = "loadBalancerAttributes.routing.http.xff_header_processing.mode"
    value = "append"
  }

  depends_on = [kubernetes_service_account.aws_load_balancer_controller]
}