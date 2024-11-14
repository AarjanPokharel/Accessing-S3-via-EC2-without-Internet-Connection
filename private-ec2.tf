resource "aws_instance" "private-ec2" {
  ami = data.aws_ami.amazon-linux_ami.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private.id
  iam_instance_profile = aws_iam_instance_profile.bastionHost_profile.name
  vpc_security_group_ids = [aws_security_group.bastion_ssh.id, ]
  key_name = var.sshkey
  availability_zone = "${var.region}a"
  
  user_data = <<EOF
              #!/bin/bash
              yum update -y
              yum install -y awscli
              EOF

  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-privateEC2"}))
}