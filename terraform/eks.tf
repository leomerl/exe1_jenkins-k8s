resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public_subnets[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment
  ]

  tags = {
    Name = "eks_cluster"
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node_group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [for subnet in aws_subnet.public_subnets : subnet.id]

  scaling_config {
    desired_size = var.eks_desired_capacity
    max_size     = var.eks_max_size
    min_size     = var.eks_min_size
  }

  instance_types = [var.eks_node_instance_type]

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only_attachment
  ]

  tags = {
    Name = "eks_node_group"
  }
}

