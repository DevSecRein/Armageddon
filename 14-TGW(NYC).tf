resource "aws_ec2_transit_gateway" "Ultramarines_NYC_TGW1" {
  provider = aws.NovaYork
  tags = {
    Name: "Ultramarines_NYC_TGW1"
  }
}

output "TWG-ID-NYC"{
    value = aws_ec2_transit_gateway.Ultramarines_NYC_TGW1.id
    description = "TGW ID"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "NYC_Tokyo_Attachment" {
  provider = aws.NovaYork
  subnet_ids         = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id]
  transit_gateway_id = aws_ec2_transit_gateway.Ultramarines_NYC_TGW1.id
  vpc_id             = aws_vpc.Ultramarines_NYC_VPC.id
  transit_gateway_default_route_table_association = false #or  by default associate to default NYC-TGW-Route-table
  transit_gateway_default_route_table_propagation = false #or  by default propagate to default NYC-TGW-Route-table
}

resource "aws_ec2_transit_gateway_peering_attachment" "Japan_US_Peer" { #peer
  provider = aws.NovaYork
  transit_gateway_id        = aws_ec2_transit_gateway.Ultramarines_NYC_TGW1.id
  peer_transit_gateway_id   = "tgw-0c09191c70d87e57e"  # Placeholder, replace with actual TGW ID
  peer_account_id           = "975050165989"         # The account ID of the TGW
  peer_region               = "ap-northeast-1"
  tags = {
    Name = "Japan-US-Peer"
  }
}

# data "aws_ec2_transit_gateway_peering_attachment" "Japan_US_Peer"{
#     id = "tgw-attach-0c05cd4e07a4ec9c9"
# }

resource "aws_ec2_transit_gateway_route_table" "Ultramarines_NYC_RT" { #TGW route table Japan 
  provider = aws.NovaYork
  transit_gateway_id = aws_ec2_transit_gateway.Ultramarines_NYC_TGW1.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "Ultramarines_NYC_TGW1_Association" { #Associates Japan-VPC-TGW-attach to Japan-TGW-Route-Table
  provider = aws.NovaYork
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.NYC_Tokyo_Attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_NYC_RT.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "Ultramarines_NYC_TGW1_Propagation" { #Propagates US-VPC-TGW-attach to Japan-TGW-Route-Table
  provider = aws.NovaYork
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.NYC_Tokyo_Attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_NYC_RT.id
}

resource "aws_ec2_transit_gateway_route_table_association" "Ultramarines_NYC_TGW1_Peer_Association" { #Associates Japan-Brazil-TGW-Peer to Japan-TGW-Route-Table
  provider = aws.NovaYork
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_US_Peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_NYC_RT.id
  replace_existing_association = true #removes default TGW-Route-Table-Association so you can Associate with the one specified in your code
}

resource "aws_ec2_transit_gateway_route" "Japan_to_US_Route" { #Route on TG Japan -> to -> Brazil
  provider = aws.NovaYork
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Ultramarines_NYC_RT.id
  destination_cidr_block         = "10.150.0.0/16"  # CIDR block of the VPC in sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_US_Peer.id
}
