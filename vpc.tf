# Main VPC for Dev Blog
resource "aws_vpc" "dblog" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"

    tags = {
        Name = "dblog_vpc"
    }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.dblog.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "subnet1"
    }
}

resource "aws_internet_gateway" "dblog-gw" {
  vpc_id = aws_vpc.dblog.id

  tags = {
    Name = "dblog-gw"
  }
}

resource "aws_route_table" "dblog-route-table" {
  vpc_id = aws_vpc.dblog.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dblog-gw.id
  }

  tags = {
    Name = "dblog-route-table"
  }
}

resource "aws_route_table_association" "dblog-tr-association" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.dblog-route-table.id
}