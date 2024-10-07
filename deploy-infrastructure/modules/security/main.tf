# Setup Security Group
resource "aws_security_group" "public_sg" {
  description = "Allow access to server"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.network_root_name}-sg-public"
    Type = "Security-Group"
    Author = var.author
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_sg_inbound_1" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  # Port
  from_port = 22
  to_port = 22
  # Protocol
  ip_protocol = "tcp"
  tags = {
    Name = "${var.network_root_name}-sg-public-inbound-rule1"
    Type = "Security-Group-Inbound-Rule"
    Author = var.author
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_sg_inbound_2" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  # Port
  from_port = 80
  to_port = 80
  # Protocol
  ip_protocol = "tcp"
  tags = {
    Name = "${var.network_root_name}-sg-public-inbound-rule2"
    Type = "Security-Group-Inbound-Rule"
    Author = var.author
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_sg_inbound_3" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  # Port
  from_port = 443
  to_port = 443
  # Protocol
  ip_protocol = "tcp"
  tags = {
    Name = "${var.network_root_name}-sg-public-inbound-rule3"
    Type = "Security-Group-Inbound-Rule"
    Author = var.author
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_sg_inbound_4" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  # Port
  from_port = 5000
  to_port = 5000
  # Protocol
  ip_protocol = "tcp"
  tags = {
    Name = "${var.network_root_name}-sg-public-inbound-rule4"
    Type = "Security-Group-Inbound-Rule"
    Author = var.author
  }
}

resource "aws_vpc_security_group_egress_rule" "public_sg_outbound" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  tags = {
    Name = "${var.network_root_name}-sg-public-outbound-rule1"
    Type = "Security-Group-Outbound-Rule"
    Author = var.author
  }
}

resource "aws_security_group" "db_sg" {
  description = "Allow server access to database server"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.network_root_name}-sg-db"
    Type = "Security-Group-Outbound-Rule"
    Author = var.author
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_sg_inbound" {
  security_group_id = aws_security_group.db_sg.id
  referenced_security_group_id = aws_security_group.public_sg.id
  # Port
  from_port = 3306
  to_port = 3306
  # Protocol
  ip_protocol = "tcp"
  tags = {
    Name = "${var.network_root_name}-sg-db-inbound-rule"
    Type = "Security-Group-Inbound-Rule"
    Author = var.author
  }
}

resource "aws_vpc_security_group_egress_rule" "private_terra_sg_outbound" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  tags = {
    Name = "${var.network_root_name}-sg-db-outbound-rule"
    Type = "Security-Group-Outbound-Rule"
    Author = var.author
  }
}