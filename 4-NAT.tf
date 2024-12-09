resource "aws_eip" "SP_nat" {
  domain = "vpc"

  tags = {
    Name = "SP_nat"
  }
}

resource "aws_nat_gateway" "SP_nat" {
  allocation_id = aws_eip.SP_nat.id
  subnet_id     = aws_subnet.public-sa-east-1a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.SP_igw]
}

#----------------------------------------------

resource "aws_eip" "NYC_nat" {
  provider = aws.NovaYork
  domain = "vpc"

  tags = {
    Name = "NYC_nat"
  }
}

resource "aws_nat_gateway" "NYC_nat" {
  provider = aws.NovaYork
  allocation_id = aws_eip.NYC_nat.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "NYC_nat"
  }

  depends_on = [aws_internet_gateway.NYC_igw]
}

resource "aws_eip" "LDN_nat" {
  provider = aws.Londres
  domain = "vpc"

  tags = {
    Name = "LDN_nat"
  }
}

resource "aws_nat_gateway" "LDN_nat" {
  provider = aws.Londres
  allocation_id = aws_eip.LDN_nat.id
  subnet_id     = aws_subnet.public-eu-west-2a.id

  tags = {
    Name = "NYC_nat"
  }

  depends_on = [aws_internet_gateway.NYC_igw]
}