# Get IP Address Input
variable "local_ip_address" {
  type = string
}

# Configure Security Group
data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group" "app_firewall" {
  name        = "app-firewall"
  description = "Rules for App Server"
  vpc_id      = data.aws_vpc.default_vpc.id
}

# Configure Rule for App Firewall Security Group
locals {
  private_ips_in_cidr_form = "${var.local_ip_address}/32"
}

resource "aws_security_group_rule" "allow_my_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [local.private_ips_in_cidr_form]
  security_group_id = aws_security_group.app_firewall.id
}

# Provision Instance and Apply Security Group
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "private_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "PowerXDevtoolsSession4HW_EC2"
  }

  vpc_security_group_ids = [aws_security_group.app_firewall.id]

  key_name = "ec2_ssh_keys"
}
