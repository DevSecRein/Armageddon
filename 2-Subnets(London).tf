#London
resource "aws_subnet" "public-eu-west-2a" {
  provider = aws.Londres
  vpc_id                  = aws_vpc.Ultramarines_London_VPC.id
  cidr_block              = "10.152.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-eu-west-2a"
  }
}

resource "aws_subnet" "private-eu-west-2a" {
  provider = aws.Londres
  vpc_id                  = aws_vpc.Ultramarines_London_VPC.id
  cidr_block              = "10.152.11.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-eu-west-2a"
  }
}

resource "aws_subnet" "public-eu-west-2b" {
  provider = aws.Londres
  vpc_id                  = aws_vpc.Ultramarines_London_VPC.id
  cidr_block              = "10.152.2.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-eu-west-2b"
  }
}

resource "aws_subnet" "private-eu-west-2b" {
  provider = aws.Londres
  vpc_id                  = aws_vpc.Ultramarines_London_VPC.id
  cidr_block              = "10.152.12.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = false

  tags = {
    Name    = "private-eu-west-2b"
  }
}