resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks_alb_role_arn
    }
  }
}

resource "null_resource" "alb_ingress_config" {
  depends_on = [var.addon_depends_on_nodegroup_no_taint]

  provisioner "local-exec" {
    command = <<EOT
            kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
            kubectl delete -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"
    EOT
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

  depends_on = [kubernetes_service_account.aws_load_balancer_controller, null_resource.alb_ingress_config]
}