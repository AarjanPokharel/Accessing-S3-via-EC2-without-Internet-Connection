provider "aws" {
  region = var.region
}

# ALL THE NETWORK RESOURCES ARE FOUND IN THE UPCOMING CODE SECTION
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidrblock
    enable_dns_hostnames = true
    enable_dns_support = true

}
