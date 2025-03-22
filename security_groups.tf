resource "aws_security_group" "dblog-http" {
  name = "allow-https"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.dblog.id

  tags = {
    Name = "allow_tls"
  } 
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.dblog-http.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.dblog-http.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.dblog-http.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}