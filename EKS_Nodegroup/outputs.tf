output node_group_with_taint_arn {
    # value = aws_eks_node_group.node_groups_with_taint[0].arn
    value = length(aws_eks_node_group.node_groups_with_taint) > 0 ? aws_eks_node_group.node_groups_with_taint[0].arn : null
}

output node_group_with_taint_id {
    # value = aws_eks_node_group.node_groups_with_taint[0].id
    value = length(aws_eks_node_group.node_groups_with_taint) > 0 ? aws_eks_node_group.node_groups_with_taint[0].id : null
}

output node_group_without_taint_arn {
    # value = aws_eks_node_group.node_groups_without_taint[0].arn
    value = length(aws_eks_node_group.node_groups_without_taint) > 0 ? aws_eks_node_group.node_groups_without_taint[0].arn : null
}

output node_group_without_taint_id {
    # value = aws_eks_node_group.node_groups_without_taint[0].id
    value = length(aws_eks_node_group.node_groups_without_taint) > 0 ? aws_eks_node_group.node_groups_without_taint[0].id : null
}

output node_group_role {
    value = aws_iam_role.eks_nodes_role.name
}