data "aws_ami" "amazon-linux_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
  }
}

data "aws_caller_identity" "caller_id"{
}  // Fetches your aws account id