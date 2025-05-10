resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false
  version          = var.chart_version
  timeout          = 1200

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      ARGOCD_DOMAIN      = var.argocd_domain_name
      ingress_group_name = var.ingress_group_name
      CERTIFICATE_ARN    = var.certificate_arn
      SUBNET_IDS         = join(",", var.subnet_ids)
      SECURITY_GROUP_IDS = join(",", var.security_group_ids)
    })
  ]

  depends_on = [kubernetes_namespace.argocd]
}

resource "helm_release" "argo-rollouts" {
  name             = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false
  version          = var.rollouts_version

  set {
    name  = "dashboard.enabled"
    value = true
  }

  depends_on = [helm_release.argocd]
}
