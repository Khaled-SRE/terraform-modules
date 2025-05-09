data "aws_caller_identity" "this" {}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "aws_iam_authenticator" {
  name = data.aws_eks_cluster.this.name
}

resource "helm_release" "external-dns" {
  name       = "external-dns"
  namespace  = var.namespace
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  version    = var.chart_version

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_dns.arn
  }

  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  set {
    name  = "zoneType"
    value = var.zone_name
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "domainFilters[0]"
    value = var.domain
  }

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "txtOwnerId"
    value = "external-dns"
  }

  set {
    name  = "interval"
    value = "1m"
  }

  set {
    name  = "registry"
    value = "txt"
  }

  set {
    name  = "logLevel"
    value = "info"
  }

  set {
    name  = "logFormat"
    value = "json"
  }

  set {
    name  = "aws.assumeRoleArn"
    value = aws_iam_role.external_dns.arn
  }

  set {
    name  = "aws.zoneType"
    value = var.zone_name
  }

  set {
    name  = "aws.evaluateTargetHealth"
    value = "true"
  }

  set {
    name  = "aws.preferredTargetType"
    value = "ip"
  }

  timeout = 600
}

resource "aws_iam_role" "external_dns" {
  name = var.external_dns_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      "ServiceAccount" = var.service_account_name
      "Namespace"      = var.namespace
      "ManagedBy"      = "terraform"
    }
  )
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns.arn
}

resource "aws_iam_policy" "external_dns" {
  name        = "${var.external_dns_role_name}_policy"
  description = "Policy for external-dns to manage Route53 records"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ChangeResourceRecordSets"
        ]
        Resource = [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ]
        Resource = [
          "*"
        ]
      }
    ]
  })

  tags = var.tags
}