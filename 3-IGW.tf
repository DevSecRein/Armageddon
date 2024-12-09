resource "aws_internet_gateway" "SP_igw" {
  vpc_id = aws_vpc.Ultramarines_Sao_Paulo_VPC.id

  tags = {
    Name    = "Ultramarines_SP_IG"
  }
}

#----------------------------------------------

resource "aws_internet_gateway" "NYC_igw" {
  provider = aws.NovaYork
  vpc_id = aws_vpc.Ultramarines_NYC_VPC.id

  tags = {
    Name    = "Ultramarines_NYC_IG"
  }
}

resource "aws_internet_gateway" "LDN_igw" {
  provider = aws.Londres
  vpc_id = aws_vpc.Ultramarines_London_VPC.id

  tags = {
    Name    = "Ultramarines_NYC_IG"
  }
}

