resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argo-cd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false
  version          = var.version
  timeout          = 1200

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      CERTIFICATE_ARN    = var.certificate_arn
      ARGOCD_DOMAIN      = var.argocd_domain_name
      ingress_group_name = var.ingress_group_name
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

  depends_on = [helm_release.argo-cd]
}
