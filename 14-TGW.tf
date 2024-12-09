resource "aws_ec2_transit_gateway" "Ultramarines_SP_TGW1" {
  provider = aws
  tags = {
    Name: "Ultramarines_SP_TGW1"
  }
}

output "TWG-ID-SP"{
    value = aws_ec2_transit_gateway.Ultramarines_SP_TGW1.id
    description = "TGW ID"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "SP_Tokyo_Attachment" {
  subnet_ids         = [aws_subnet.private-sa-east-1a.id, aws_subnet.private-sa-east-1c.id]
  transit_gateway_id = aws_ec2_transit_gateway.Ultramarines_SP_TGW1.id
  vpc_id             = aws_vpc.Ultramarines_Sao_Paulo_VPC.id
  transit_gateway_default_route_table_association = false #or  by default associate to default Japan-TGW-Route-table
  transit_gateway_default_route_table_propagation = false #or  by default propagate to default Japan-TGW-Route-table
}

resource "aws_ec2_transit_gateway_peering_attachment" "Japan_Brazil_Peer" { #peer
  transit_gateway_id        = aws_ec2_transit_gateway.Ultramarines_SP_TGW1.id
  peer_transit_gateway_id   = "tgw-0c09191c70d87e57e"  # Placeholder, replace with actual TGW ID
  peer_account_id           = "975050165989"           # The account ID of the Tokyo TGW
  peer_region               = "ap-northeast-1"
  tags = {
    Name = "Japan-Brazil-Peer"
  }
}

# data "aws_ec2_transit_gateway_peering_attachment" "Japan_Brazil_Peer"{
#     id = "tgw-attach-09a504fca7e861da7"
# }

resource "aws_ec2_transit_gateway_route_table" "Ultramarines_SP_RT" { #TGW route table Japan 
  transit_gateway_id = aws_ec2_transit_gateway.Ultramarines_SP_TGW1.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "Ultramarines_SP_TGW1_Association" { #Associates Japan-VPC-TGW-attach to Japan-TGW-Route-Table
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.SP_Tokyo_Attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_SP_RT.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "Ultramarines_SP_TGW1_Propagation" { #Propagates US-VPC-TGW-attach to Japan-TGW-Route-Table
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.SP_Tokyo_Attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_SP_RT.id
}

resource "aws_ec2_transit_gateway_route_table_association" "Ultramarines_SP_TGW1_Peer_Association" { #Associates Japan-Brazil-TGW-Peer to Japan-TGW-Route-Table
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_SP_RT.id
  replace_existing_association = true #removes default TGW-Route-Table-Association so you can Associate with the one specified in your code
}

resource "aws_ec2_transit_gateway_route" "Japan_to_Brazil_Route" { #Route on TG Japan -> to -> Brazil
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_SP_RT.id
  destination_cidr_block         = "10.150.0.0/16"  # CIDR block of the VPC in sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
}

