resource "aws_ec2_transit_gateway" "Ultramarines_LDN_TGW1" {
  provider = aws.Londres
  tags = {
    Name: "Ultramarines_London_TGW1"
  }
}

output "TWG-ID-LDN"{
    value = aws_ec2_transit_gateway.Ultramarines_LDN_TGW1.id
    description = "TGW ID"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "London_Tokyo_Attachment" {
  provider = aws.Londres
  subnet_ids         = [aws_subnet.private-eu-west-2a.id, aws_subnet.private-eu-west-2b.id]
  transit_gateway_id = aws_ec2_transit_gateway.Ultramarines_LDN_TGW1.id
  vpc_id             = aws_vpc.Ultramarines_London_VPC.id
  transit_gateway_default_route_table_association = false 
  transit_gateway_default_route_table_propagation = false
}

resource "aws_ec2_transit_gateway_peering_attachment" "Japan_UK_Peer" {
  provider = aws.Londres
  transit_gateway_id        = aws_ec2_transit_gateway.Ultramarines_NYC_TGW1.id
  peer_transit_gateway_id   = "tgw-0c09191c70d87e57e"  
  peer_account_id           = "975050165989"         
  peer_region               = "ap-northeast-1"
  tags = {
    Name = "Japan-US-Peer"
  }
}

# data "aws_ec2_transit_gateway_peering_attachment" "Japan_UK_Peer"{
#     id = "tgw-attach-0c7c52df89bf92f21"
# }

resource "aws_ec2_transit_gateway_route_table" "Ultramarines_LDN_RT" {
  provider = aws.Londres
  transit_gateway_id = aws_ec2_transit_gateway.Ultramarines_LDN_TGW1.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "Ultramarines_LDN_TGW1_Association" {
  provider = aws.Londres
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.London_Tokyo_Attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_LDN_RT.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "Ultramarines_LDN_TGW1_Propagation" { 
  provider = aws.Londres
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.London_Tokyo_Attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_LDN_RT.id
}

resource "aws_ec2_transit_gateway_route_table_association" "Ultramarines_LDN_TGW1_Peer_Association" { 
  provider = aws.Londres
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_UK_Peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_LDN_RT.id
  replace_existing_association = true
}

resource "aws_ec2_transit_gateway_route" "Japan_to_UK_Route" {
  provider = aws.Londres
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_LDN_RT.id
  destination_cidr_block         = "10.150.0.0/16"  # CIDR block of the VPC in sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_UK_Peer.id
}
