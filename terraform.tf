provider "aws" {
  region = var.region
}

# ALL THE NETWORK RESOURCES ARE FOUND IN THE UPCOMING CODE SECTION
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidrblock
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = merge(local.common_tags, tomap({"Name" = "${local.prefix}-vpc"}))
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr[0]
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"

  tags = merge(local.common_tags, tomap({"Name" = "${local.prefix}-publicSubnet"}))
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr[1]
  availability_zone = "${var.region}a"

  tags = merge(local.common_tags, tomap({"Name" = "${local.prefix}-privateSubnet"}))
}

resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, tomap({"Name" = "${local.prefix}-IGW"}))
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, tomap({"Name" = "${local.prefix}-publicRoute"}))
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, tomap({"Name" = "${local.prefix}-privateRoute"}))
}

resource "aws_route_table_association" "public_association" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public.id
}

resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private.id
}

resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.igw_main.id
  destination_cidr_block = "0.0.0.0/0"
}

