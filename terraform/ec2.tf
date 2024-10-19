resource "aws_instance" "ec2_instance" {
  count                       = length(aws_subnet.public_subnets)
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.public_subnets[count.index].id
  vpc_security_group_ids      = [aws_security_group.main_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = "ec2_instance_${count.index + 1}"
  }

  depends_on = [aws_key_pair.ec2_key_pair]
}

resource "tls_private_key" "ec2_key_pair" {
  algorithm   = "RSA"
  rsa_bits    = 2048
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2_key_pair_auto"
  public_key = tls_private_key.ec2_key_pair.public_key_openssh
}

