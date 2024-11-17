
resource "aws_security_group" "private_ssh" {
  description = "SSH into EC2 and HTTP/HTTPS out of  EC2"
  name = "${local.prefix}-privateEC2_ssh"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    security_groups = ["${aws_security_group.bastion_ssh.id}", ]
  }

  egress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  tags = local.common_tags
}