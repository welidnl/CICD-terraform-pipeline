resource "aws_vpc" "tf_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "Public_Subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id # links the subnet to VPC
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true # gives the instance a public IP

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-igw"
  }
}

resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "tf-rt"
  }
}

resource "aws_route_table_association" "rt_subnet_assoc" {
  subnet_id      = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.tf_rt.id
}




