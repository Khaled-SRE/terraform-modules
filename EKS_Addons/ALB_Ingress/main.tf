data "template_file" "service_account" {
  template = file("${path.module}/templates/alb-ingress-service-account.yaml")

  vars = {
    eks_alb_role_arn = "${var.eks_alb_role_arn}"
  }
}

resource "null_resource" "alb_ingress_config" {
  depends_on = [var.addon_depends_on_nodegroup_no_taint]

  provisioner "local-exec" {
    command = <<EOT
            kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
            echo  '${data.template_file.service_account.rendered}' | kubectl apply -f -
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
            kubectl delete -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
            kubectl delete serviceaccount -n kube-system aws-load-balancer-controller
    EOT
  }
}

resource "helm_release" "alb-ingress" {
  name       = "alb-ingress"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  depends_on = [null_resource.alb_ingress_config]
  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
    name  = "serviceAccount.create"
    value = false
  }
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
}