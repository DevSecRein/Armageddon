resource "aws_subnet" "public-us-east-1a" {
  provider = aws.NovaYork
  vpc_id                  = aws_vpc.Ultramarines_NYC_VPC.id
  cidr_block              = "10.151.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1a"
  }
}

resource "aws_subnet" "private-us-east-1a" {
  provider = aws.NovaYork
  vpc_id                  = aws_vpc.Ultramarines_NYC_VPC.id
  cidr_block              = "10.151.11.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-us-east-1a"
  }
}

resource "aws_subnet" "public-us-east-1b" {
  provider = aws.NovaYork
  vpc_id                  = aws_vpc.Ultramarines_NYC_VPC.id
  cidr_block              = "10.151.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1b"
  }
}

resource "aws_subnet" "private-us-east-1b" {
  provider = aws.NovaYork
  vpc_id                  = aws_vpc.Ultramarines_NYC_VPC.id
  cidr_block              = "10.151.12.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-us-east-1b"
  }
}