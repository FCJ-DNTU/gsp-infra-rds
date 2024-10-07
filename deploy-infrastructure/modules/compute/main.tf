# Setup EC2 Instance
resource "aws_instance" "my_server" {
  # Use Ubuntu Server 24.04 LTS
  ami = "ami-047126e50991d067b"
  instance_type = "t2.micro"
  # Change your key-pair here
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.compute_root_name}_my_server"
    Type = "EC2"
    Author = var.author
  }
}