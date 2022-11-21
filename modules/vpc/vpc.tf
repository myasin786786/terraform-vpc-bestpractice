# ---- VPC creation ---- #

resource "aws_vpc" "VPC" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags                 = merge({ Name = "${local.infra_env}-VPC" }, var.project_tags)
}

# ---- Internet Gateway ---- #

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags   = merge({ Name = "${local.infra_env}-IGW" }, var.project_tags)
}

# ---- Elastic IP for NAT GW ---- #

resource "aws_eip" "EIP" {
  vpc  = true
  tags = merge({ Name = "${local.infra_env}-EIP" }, var.project_tags)
}

# ---- Public Subnet ---- #

resource "aws_subnet" "Public-Subnet" {
  count                   = var.number_of_public_subnets
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index + 1)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.AZN.names[count.index]
  tags                    = merge({ Name = "${local.infra_env}-Public-Subnet-${count.index + 1}" }, var.project_tags)
}

# ---- Private Subnet  ---- #

resource "aws_subnet" "Private-Subnet" {
  count                   = var.number_of_private_subnets
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index + 1 + var.number_of_public_subnets)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.AZN.names[count.index]
  tags                    = merge({ Name = "${local.infra_env}-Private-Subnet-${count.index + 1}" }, var.project_tags)
}

# ---- Route Tables Private ---- #

resource "aws_route_table" "Private-RT" {
  vpc_id = aws_vpc.VPC.id
  tags = merge({ Name = "${local.infra_env}-Private-RT" }, var.project_tags)
}

# ---- Route Tables Public ---- #

resource "aws_default_route_table" "Public-RT" {
  default_route_table_id = aws_vpc.VPC.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = merge({ Name = "${local.infra_env}-Public-RT" }, var.project_tags)
}

# ---- Subnet Association for Private Subnets ---- #

resource "aws_route_table_association" "Subnet-Association-Private" {
  for_each       = { for subnet, v in aws_subnet.Private-Subnet : subnet => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.Private-RT.id
}