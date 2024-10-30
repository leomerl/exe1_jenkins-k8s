output "ec2_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = [for instance in aws_instance.ec2_instance : instance.public_ip]
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "ecr_repository_url" {
  description = "ECR Repository URL"
  value       = aws_ecr_repository.ecr_repo.repository_url
}

output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "aws_region" {
  description = "AWS Region"
  value       = var.aws_region
}

output "ec2_private_key_pem" {
  description = "Private key of the EC2 key pair in PEM format"
  value       = tls_private_key.ec2_key_pair.private_key_pem
  sensitive   = true
}