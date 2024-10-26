# Setup EC2 Instance
resource "aws_instance" "my_server" {
  # Use Ubuntu Server 24.04 LTS (Singapore)
  # ami = "ami-047126e50991d067b"
  # Use Ubuntu Server 24.04 LTS (Sydney)
  ami = "ami-001f2488b35ca8aad"
  instance_type = "t2.micro"
  # Change your key-pair here
  key_name = var.key_name
  subnet_id = var.public_subnet_1_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.compute_root_name}-my-server"
    Type = "EC2"
    Author = var.author
  }
}

# Setup ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.compute_root_name}-cluster"
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.compute_root_name}-cluster"
    Type = "ECS-Cluster"
    Author = var.author
  }
}

# Setup Target Group
resource "aws_lb_target_group" "fe_tg" {
  name = "${var.compute_root_name}-tg-fe"
  target_type = "ip"
  protocol = "HTTP"
  port = 80
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.compute_root_name}-tg-fe"
    Type = "Target-Group"
    Author = var.author
  }
}

# Setup ALB
resource "aws_lb" "alb" {
  name = "${var.compute_root_name}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = var.security_group_ids
  subnets = [ var.public_subnet_1_id, var.public_subnet_2_id ]

  tags = {
    Name = "${var.compute_root_name}-alb"
    Type = "Load-Balancer"
    Author = var.author
  }
}