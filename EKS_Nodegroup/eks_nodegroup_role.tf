resource "aws_iam_role" "eks_nodes_role" {
  name = var.eks_nodes_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "cluster_autoScaler_policy" {
  name   = "${var.eks_nodes_role_name}-NG-CLUSTERAUTOSCALER-POLICY"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "cloudfront_policy" {
  name   = "${var.eks_nodes_role_name}-NG-CLOUDFRONT-POLICY"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudfront:GetCloudFrontOriginAccessIdentityConfig",
                "cloudfront:GetFunction",
                "cloudfront:GetCachePolicyConfig",
                "cloudfront:GetStreamingDistributionConfig",
                "cloudfront:GetResponseHeadersPolicy",
                "cloudfront:GetInvalidation",
                "cloudfront:GetOriginRequestPolicyConfig",
                "cloudfront:GetDistribution",
                "cloudfront:GetResponseHeadersPolicyConfig",
                "cloudfront:GetRealtimeLogConfig",
                "cloudfront:DescribeFunction",
                "cloudfront:ListConflictingAliases",
                "cloudfront:GetStreamingDistribution",
                "cloudfront:ListTagsForResource",
                "cloudfront:GetFieldLevelEncryption",
                "cloudfront:GetOriginRequestPolicy",
                "cloudfront:ListInvalidations",
                "cloudfront:GetCloudFrontOriginAccessIdentity",
                "cloudfront:UpdateDistribution",
                "cloudfront:GetCachePolicy",
                "cloudfront:GetDistributionConfig",
                "cloudfront:GetFieldLevelEncryptionProfileConfig",
                "cloudfront:GetFieldLevelEncryptionConfig",
                "cloudfront:GetFieldLevelEncryptionProfile"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "cloudfront:ListCloudFrontOriginAccessIdentities",
                "cloudfront:ListResponseHeadersPolicies",
                "cloudfront:ListDistributionsByCachePolicyId",
                "cloudfront:ListFunctions",
                "cloudfront:ListFieldLevelEncryptionConfigs",
                "cloudfront:GetPublicKeyConfig",
                "cloudfront:ListDistributionsByLambdaFunction",
                "cloudfront:GetPublicKey",
                "cloudfront:ListCachePolicies",
                "cloudfront:GetMonitoringSubscription",
                "cloudfront:ListDistributionsByKeyGroup",
                "cloudfront:ListOriginRequestPolicies",
                "cloudfront:ListDistributionsByRealtimeLogConfig",
                "cloudfront:ListPublicKeys",
                "cloudfront:ListKeyGroups",
                "cloudfront:ListRealtimeLogConfigs",
                "cloudfront:GetKeyGroup",
                "cloudfront:ListDistributions",
                "cloudfront:ListFieldLevelEncryptionProfiles",
                "cloudfront:ListStreamingDistributions",
                "cloudfront:GetKeyGroupConfig",
                "cloudfront:ListDistributionsByWebACLId",
                "cloudfront:ListDistributionsByResponseHeadersPolicyId",
                "cloudfront:ListDistributionsByOriginRequestPolicyId"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "cluster_custom_policy" {
  name   = "${var.eks_nodes_role_name}-NG-CLUSTER-CUSTOM-POLICY"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "rds:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole",
                "iam:GetRole",
                "iam:ListAttachedRolePolicies"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
          "Sid": "VisualEditor4",
          "Effect":"Allow",
          "Action":[
            "ses:*"
          ],
          "Resource":"*"
        },
        {
          "Sid": "VisualEditor5",
          "Effect":"Allow",
          "Action":[
            "sns:*"
          ],
          "Resource":"*"
        },
                {
          "Sid": "VisualEditor6",
          "Effect":"Allow",
          "Action":[
            "ec2:*"
          ],
          "Resource":"*"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "sns_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  policy_arn = aws_iam_policy.cluster_autoScaler_policy.arn
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "secret_manager_policy_for_eks_nodes" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  policy_arn = aws_iam_policy.cluster_custom_policy.arn
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "cloudfront" {
  policy_arn = aws_iam_policy.cloudfront_policy.arn
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "sqs_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  role       = aws_iam_role.eks_nodes_role.name
}