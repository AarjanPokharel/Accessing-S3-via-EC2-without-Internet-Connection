resource "aws_instance" "bastionHost" {
  ami = data.aws_ami.amazon-linux_ami.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.bastion_ssh.id, ]
  key_name = var.sshkey
  iam_instance_profile = aws_iam_instance_profile.bastionHost_profile.name
  availability_zone = "${var.region}a"

  tags = merge(local.common_tags, tomap({"Name" = "${local.prefix}-bastionHost"}))

  connection {
    type = "ssh"
    user = "ec2-user"
    password = ""
    private_key = file(var.keyPath)
    host = self.public_ip
  }

  provisioner "file" {
    source = "setup_script.sh"
    destination = "/tmp/setup_script.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/setup_script.sh",
        "bash /tmp/setup_script.sh"
     ]
  }
  depends_on = [ aws_route.public_internet_access ]
}


