# VPC & Subnets
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name      = "shangrila-${var.cidr_block}-vpc"
    Project   = "shangrila"
    ManagedBy = "terraform"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route" "internet_route" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.primary_subnet_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name      = "shangrila-${var.primary_subnet_cidr_block}-subnet"
    Project   = "shangrila"
    ManagedBy = "terraform"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.secondary_subnet_cidr_block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name      = "shangrila-${var.secondary_subnet_cidr_block}-subnet"
    Project   = "shangrila"
    ManagedBy = "terraform"
  }
}

# Default Security Group of VPC
resource "aws_security_group" "default" {
  name        = "default-sg"
  description = "Default SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.main.id
  depends_on = [
    aws_vpc.main
  ]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Name      = "shangrila-security-group"
    Project   = "shangrila"
    ManagedBy = "terraform"
  }

}
