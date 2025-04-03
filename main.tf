provider "aws"{
  region = "ap-south-1"
  access_key = var.Access_Key
  secret_key = var.Secret_Key
}

resource "aws_instance" "python_ec2_instance"{
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "my_python_ec2_instance"
  }
}

resource "aws_vpc" "python_vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_python_vpc"
  }
}

resource "aws_subnet" "python_subnet"{
  vpc_id = aws_vpc.python_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-south-1a"
  map_public_ip_on_launch = true 
  tags = {
  Name = "my_python_subnet"
  }
}

resource "aws_internet_gateway" "python_gateway" {
  vpc_id = aws_vpc.python_vpc.id  # Associate with the VPC created above

  tags = {
    Name = "my_python_gateway"
  }
}

resource "aws_route_table" "python_route_table" {
  vpc_id = aws_vpc.python_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  # Route all traffic to the internet
    gateway_id = aws_internet_gateway.python_gateway.id  # Direct the traffic to the internet gateway
  }
  tags = {
    Name = "my_python_route_table"
  }
}

resource "aws_route_table_association" "python_subnet_association" {
  subnet_id      = aws_subnet.python_subnet.id
  route_table_id = aws_route_table.python_route_table.id
}