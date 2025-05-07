data "template_file" "namespace" {
  template = file("${path.module}/templates/argocd_ns.yaml")
}


resource "null_resource" "argo_cd_ns" {
  depends_on = [var.addon_depends_on_nodegroup_no_taint]
  provisioner "local-exec" {

    command = "kubectl apply -f -<<EOF\n${data.template_file.namespace.rendered}\nEOF"
  }
}



resource "helm_release" "argo-cd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"
  version    = "5.27.3"
  timeout    = "1200"
  depends_on = [null_resource.argo_cd_ns, var.addon_depends_on_nodegroup_no_taint]
  values     = [templatefile("${path.module}/templates/install.yaml", {})]
}

data "template_file" "ingress" {
  template = file("${path.module}/templates/argocd_ingress.yaml")
  vars = {
    # argo_cd_lb_acm_arn         = "${var.argo_cd_lb_acm_arn}"
    argo_cd_lb_security_group  = "${var.argo_cd_lb_security_group}"
    argo_cd_lb_security_group2 = "${var.argo_cd_lb_security_group2}"
    argo_cd_lb_subnet1         = "${var.argo_cd_lb_subnet1}"
    argo_cd_lb_subnet2         = "${var.argo_cd_lb_subnet2}"
    ingress_group_name         = "${var.ingress_group_name}"
    argo_cd_lb_domain_name     = "${var.argo_cd_lb_domain_name}"

  }
}

resource "null_resource" "argo_cd_ingress" {
  depends_on = [helm_release.argo-cd]

  provisioner "local-exec" {
    command = "kubectl apply -f -<<EOF\n${data.template_file.ingress.rendered}\nEOF"
  }

}


resource "null_resource" "argo_cd_rollouts" {
  depends_on = [null_resource.argo_cd_ingress]
  provisioner "local-exec" {
     command = <<EOT
         helm repo add argo https://argoproj.github.io/argo-helm
         helm upgrade --install my-release argo/argo-rollouts --set dashboard.enabled=true
     EOT

  }
}