resource "kubernetes_manifest" "storageclass" {
  manifest = yamldecode(templatefile("${path.module}/templates/storageclass.yaml", {
    efs_filesystem_id = var.efs_filesystem_id
    storageclass_name = var.storageclass_name
  }))
}