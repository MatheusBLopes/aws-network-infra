resource "aws_network_acl" "network_acl" {
  vpc_id = aws_vpc.k8svpc.id

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

resource "aws_network_acl_association" "network_acl_association" {
  subnet_id = aws_subnet.public-us-east-1a.id
  network_acl_id = aws_network_acl.network_acl.id
}

resource "aws_network_acl_association" "network_acl_association" {
  subnet_id = aws_subnet.public-us-east-1b.id
  network_acl_id = aws_network_acl.network_acl.id
}