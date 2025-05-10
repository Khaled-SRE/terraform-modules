resource "aws_eks_node_group" "node_groups_with_taint" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = var.node_group_subnets
  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }
  ami_type       = var.node_group_ami_type
  capacity_type  = var.node_group_capacity_type
  disk_size      = var.node_group_disk_size
  instance_types = var.node_group_instance_types
  labels = {
    role = var.node_group_role
  }
  count = var.use_taint ? 1 : 0
  taint {
    key    = var.taint_key
    value  = var.taint_value
    effect = var.taint_effect
  }
  version = var.node_group_version
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    var.eks_cluster_arn
  ]
}


resource "aws_eks_node_group" "node_groups_without_taint" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = var.node_group_subnets
  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }
  ami_type       = var.node_group_ami_type
  capacity_type  = var.node_group_capacity_type
  disk_size      = var.node_group_disk_size
  instance_types = var.node_group_instance_types
  labels = {
    role = var.node_group_role
  }
  count   = var.use_taint ? 0 : 1
  version = var.node_group_version
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    var.eks_cluster_arn
  ]
}