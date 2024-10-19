variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of Availability Zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c94855ba95c71c99"
}

variable "eks_node_instance_type" {
  description = "EKS node group instance type"
  default     = "t3.small"
}

variable "eks_desired_capacity" {
  description = "Desired capacity for the EKS node group"
  default     = 1
}

variable "eks_min_size" {
  description = "Minimum size for the EKS node group"
  default     = 1
}

variable "eks_max_size" {
  description = "Maximum size for the EKS node group"
  default     = 1
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  default     = "ecr-repo"
}

