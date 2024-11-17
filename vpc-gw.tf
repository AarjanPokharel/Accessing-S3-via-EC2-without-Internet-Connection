resource "aws_vpc_endpoint" "vpc_gateway_endpoint" {
  vpc_id = aws_vpc.main.id
  vpc_endpoint_type = "Gateway"
  service_name = "com.amazonaws.us-east-1.s3"
  route_table_ids = [ aws_route_table.private.id, ]
}