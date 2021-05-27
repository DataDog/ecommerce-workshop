data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
  request_headers = {
    Accept = "application/text"
  }
}

resource "aws_vpc" "ecommerceapp-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name  = "ecommerceapp"
    Owner = var.owner
  }
}

resource "aws_subnet" "ecommerceapp-subnet" {
  vpc_id                  = aws_vpc.ecommerceapp-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.region}${var.az}"
  tags = {
    Name  = "ecommerceapp"
    Owner = var.owner
  }
}

resource "aws_internet_gateway" "ecommerceapp-igw" {
  vpc_id = aws_vpc.ecommerceapp-vpc.id
  tags = {
    Name  = "ecommerceapp"
    Owner = var.owner
  }
}

resource "aws_route_table" "ecommerceapp-crt" {
  vpc_id = aws_vpc.ecommerceapp-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecommerceapp-igw.id
  }
  tags = {
    Name  = "ecommerceapp"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "ecommerceapp-crta-subnet" {
  subnet_id      = aws_subnet.ecommerceapp-subnet.id
  route_table_id = aws_route_table.ecommerceapp-crt.id
}

resource "aws_security_group" "ecommerceapp-sg" {
  name        = "ecommerceapp-sg"
  description = "Security group created for ecommerceapp on EC2"
  vpc_id      = aws_vpc.ecommerceapp-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.ecommerceapp-subnet.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "ecommerceapp"
    Owner = var.owner
  }

}

