# Setup VPC
resource "aws_vpc" "mainvpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.network_root_name}-vpc"
    Type = "VPC"
    Author = var.author
  }
}

## Setup subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.network_root_name}-subnet-public1-${var.region}a"
    Type = "Subnet"
    Author = var.author
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.network_root_name}-subnet-private1-${var.region}a"
    Type = "Subnet"
    Author = var.author
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.network_root_name}-subnet-public2-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.network_root_name}-subnet-private2-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.network_root_name}-subnet-private3-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

resource "aws_subnet" "private_subnet_4" {
  vpc_id = aws_vpc.mainvpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.network_root_name}-subnet-private4-${var.region}b"
    Type = "Subnet"
    Author = var.author
  }
}

## Setup internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = "${var.network_root_name}-igw"
    Type = "Internet-Gateway"
    Author = var.author
  }
}

## Setup nat gateway
resource "aws_eip" "nat_gw_eip" {
  tags = {
    Name = "${var.network_root_name}-eip"
    Type = "Elastic-IP"
    Author = var.author
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id = aws_subnet.public_subnet_1.id
  connectivity_type = "public"

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    Name = "${var.network_root_name}-nat-gw"
    Type = "NAT-Gateway"
    Author = var.author
  }
}

## Setup route table and its associations
resource "aws_route_table" "public_route_table_1" {
  vpc_id = aws_vpc.mainvpc.id

  # Internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  # Local
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.network_root_name}-rtb-public"
    Type = "Route-Table"
    Author = var.author
  }
}

resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.mainvpc.id

  # Local
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  # NAT Gateway
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.network_root_name}-rtb-private"
    Type = "Route-Table"
    Author = var.author
  }
}

resource "aws_route_table_association" "public_association_1" {
  route_table_id = aws_route_table.public_route_table_1.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_association_2" {
  route_table_id = aws_route_table.public_route_table_1.id
  subnet_id = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "private_association_1" {
  route_table_id = aws_route_table.private_route_table_1.id
  subnet_id = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private_association_2" {
  route_table_id = aws_route_table.private_route_table_1.id
  subnet_id = aws_subnet.private_subnet_2.id
}

resource "aws_route_table_association" "private_association_3" {
  route_table_id = aws_route_table.private_route_table_1.id
  subnet_id = aws_subnet.private_subnet_3.id
}

resource "aws_route_table_association" "private_association_4" {
  route_table_id = aws_route_table.private_route_table_1.id
  subnet_id = aws_subnet.private_subnet_4.id
}