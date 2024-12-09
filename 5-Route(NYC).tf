resource "aws_route_table" "NYC_private" {
  provider = aws.NovaYork
  vpc_id = aws_vpc.Ultramarines_NYC_VPC.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.NYC_nat.id
      carrier_gateway_id         = null
      core_network_arn           = null
      destination_prefix_list_id = null
      egress_only_gateway_id     = null
      gateway_id                 = null
      instance_id                = null
      ipv6_cidr_block            = null
      local_gateway_id           = null
      network_interface_id       = null
      transit_gateway_id         = null
      vpc_endpoint_id            = null
      vpc_peering_connection_id  = null
    },

   {
      cidr_block                 = "10.0.0.0/8"
      transit_gateway_id         = aws_ec2_transit_gateway.Ultramarines_NYC_TGW1.id
      gateway_id                 = null
      nat_gateway_id             = null
      carrier_gateway_id         = null
      core_network_arn           = null
      destination_prefix_list_id = null
      egress_only_gateway_id     = null
      instance_id                = null
      ipv6_cidr_block            = null
      local_gateway_id           = null
      network_interface_id       = null
      vpc_endpoint_id            = null
      vpc_peering_connection_id  = null
    }
  ]

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "NYC_public" {
  provider = aws.NovaYork
  vpc_id = aws_vpc.Ultramarines_NYC_VPC.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.NYC_igw.id
      nat_gateway_id             = null
      carrier_gateway_id         = null
      core_network_arn           = null
      destination_prefix_list_id = null
      egress_only_gateway_id     = null
      instance_id                = null
      ipv6_cidr_block            = null
      local_gateway_id           = null
      network_interface_id       = null
      transit_gateway_id         = null
      vpc_endpoint_id            = null
      vpc_peering_connection_id  = null
    },
  ]

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private-us-east-1a" {
  provider = aws.NovaYork
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.NYC_private.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  provider = aws.NovaYork
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.NYC_private.id
}

#public

resource "aws_route_table_association" "public-us-east-1a" {
  provider = aws.NovaYork
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.NYC_public.id
}

resource "aws_route_table_association" "public-sa-east-1b" {
  provider = aws.NovaYork
  subnet_id      = aws_subnet.public-us-east-1b.id
  route_table_id = aws_route_table.NYC_public.id
}
