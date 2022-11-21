output "Private_Subnet_IDs" {
  value = aws_subnet.Private-Subnet.*.id
}

output "VPC_ID" {
  value = aws_vpc.VPC.id
}

output "Public_Subnet_IDs" {
  value = aws_subnet.Public-Subnet.*.id
}
