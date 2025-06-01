output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public)[*].id
}

# output "private_subnet_ids" {
#   value = values(aws_subnet.private)[*].id
# }

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}


output "vpc_endpoint_s3_id" {
  value = aws_vpc_endpoint.s3.id
}

output "vpc_endpoint_dynamodb_id" {
  value = aws_vpc_endpoint.dynamodb.id
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}
