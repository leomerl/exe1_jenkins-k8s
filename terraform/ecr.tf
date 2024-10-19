resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecr_repository_name

  tags = {
    Name = var.ecr_repository_name
  }
}

