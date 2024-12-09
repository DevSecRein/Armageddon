resource "aws_vpc" "Ultramarines_Sao_Paulo_VPC" {
  cidr_block = "10.153.0.0/16"

  tags = {
    Name = "Ultramarines_Sao_Paulo_VPC"
    Service = "Armageddon"
    Owner = "Onaray Yenimi"
  }
}
#--------------------------------------------------------
resource "aws_vpc" "Ultramarines_NYC_VPC" {
  provider = aws.NovaYork
  cidr_block = "10.151.0.0/16"

  tags = {
    Name = "Ultramarines_NYC_VPC"
    Service = "Armageddon"
    Owner = "Onaray Yenimi"
  }
}

resource "aws_vpc" "Ultramarines_London_VPC" {
  provider = aws.Londres
  cidr_block = "10.152.0.0/16"

  tags = {
    Name = "Ultramarines_London_VPC"
    Service = "Armageddon"
    Owner = "Onaray Yenimi"
  }
}


