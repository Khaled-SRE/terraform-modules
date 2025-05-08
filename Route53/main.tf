resource "aws_route53_zone" "this" {
  name    = var.domain
  comment = coalesce(var.description, "Managed by Terraform for external-dns")

  dynamic "vpc" {
    for_each = var.private_zone != null ? [1] : []

    content {
      vpc_id     = var.private_zone.vpc_id
      vpc_region = var.private_zone.vpc_region
    }
  }

  tags = merge(
    var.tags,
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/external-dns"           = "true"
    }
  )
}