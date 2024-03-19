resource "aws_vpc" "quizhero_vpc" {
  cidr_block  = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "quizhero_subnet_1" {
  vpc_id = aws_vpc.quizhero_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "quizhero_subnet_2" {
  vpc_id = aws_vpc.quizhero_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "quizhero_gateway" {
  vpc_id = aws_vpc.quizhero_vpc.id
}

resource "aws_route_table" "quizhero_route_table" {
  vpc_id = aws_vpc.quizhero_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.quizhero_gateway.id
  }
}

resource "aws_route_table_association" "quizhero_route_table_association" {
  subnet_id = aws_subnet.quizhero_subnet_1.id
  route_table_id = aws_route_table.quizhero_route_table.id
}



resource "aws_network_acl" "quizhero_network_acl" {
  vpc_id = aws_vpc.quizhero_vpc.id

  ingress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }

  egress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }
}

resource "aws_network_acl_association" "quizhero_network_acl_association" {
  subnet_id = aws_subnet.quizhero_subnet_1.id
  network_acl_id = aws_network_acl.quizhero_network_acl.id
}


resource "aws_security_group" "quizhero_security_group" {
  name   = "quizhero_rds"
  vpc_id = aws_vpc.quizhero_vpc.id

  ingress {
    from_port   = 0
    to_port     = 6000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 6000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "quizhero_rds"
  }
}


resource "aws_security_group_rule" "quizhero_security_group_rule" {
  type = "egress"
  security_group_id = aws_security_group.quizhero_security_group.id

  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
