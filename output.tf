output "bastion_public_ip" {
  value = aws_instance.bastionHost.public_ip
}

output "s3-bucket-name" {
  value = aws_s3_bucket.mys3bucket.id
}