data "template_file" "argocd_values" {
  template = file("${path.module}/templates/values.yaml")

  vars = {
    CERTIFICATE_ARN    = var.certificate_arn
    ARGOCD_DOMAIN      = var.argocd_domain_name
    ingress_group_name = var.ingress_group_name
  }
}

resource "helm_release" "argo-cd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          =  var.version  
  timeout          = "1200"
  values           = [data.template_file.argocd_values.rendered]
}
