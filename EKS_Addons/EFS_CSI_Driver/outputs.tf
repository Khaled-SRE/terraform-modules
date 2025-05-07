output "csi_driver" {
    value = helm_release.efs-csi.status
}
