resource "aws_subnet" "public-sa-east-1a" {
  vpc_id                  = aws_vpc.Ultramarines_Sao_Paulo_VPC.id
  cidr_block              = "10.153.1.0/24"
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-sa-east-1a"
  }
}

resource "aws_subnet" "private-sa-east-1a" {
  vpc_id                  = aws_vpc.Ultramarines_Sao_Paulo_VPC.id
  cidr_block              = "10.153.11.0/24"
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-sa-east-1a"
  }
}

resource "aws_subnet" "public-sa-east-1c" {
  vpc_id                  = aws_vpc.Ultramarines_Sao_Paulo_VPC.id
  cidr_block              = "10.153.3.0/24"
  availability_zone       = "sa-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-sa-east-1c"
  }
}

resource "aws_subnet" "private-sa-east-1c" {
  vpc_id                  = aws_vpc.Ultramarines_Sao_Paulo_VPC.id
  cidr_block              = "10.153.13.0/24"
  availability_zone       = "sa-east-1c"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-sa-east-1c"
  }
}

