data "template_file" "service_account" {
  template = file("${path.module}/templates/efs-service-account.yaml")

  vars = {
    eks_efs_role_arn = "${var.eks_efs_role_arn}"
  }
}

resource "helm_release" "efs-csi" {
  depends_on = [var.addon_depends_on_nodegroup_no_taint]
  name       = "efs-csi"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver"
  chart      = "aws-efs-csi-driver"
  namespace  = "kube-system"
  provisioner "local-exec" {
    command = <<EOT
            echo  '${data.template_file.service_account.rendered}' | kubectl apply -f -
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      kubectl delete serviceaccount -n kube-system efs-csi-controller-sa
    EOT
  }
}
