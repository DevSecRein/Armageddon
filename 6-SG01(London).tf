resource "aws_security_group" "Ultramarines_LDN-ASG01-SG01" {
  provider = aws.Londres
  name        = "Ultramarines_LDN-ASG01-SG01"
  description = "Ultramarines_LDN-ASG01-SG01"
  vpc_id      = aws_vpc.Ultramarines_London_VPC.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Syslog"
    from_port   = 514
    to_port     = 514
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Syslog"
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   description = "MyEvilBox"
  #   from_port   = 3389
  #   to_port     = 3389
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Ultramarines_NYC-ASG01-SG01"
    Location = "London"
  }

}

resource "aws_security_group" "Ultramarines_LDN-lb01-sg01" {
  provider = aws.Londres
  name        = "Ultramarines_LDN-lb01-sg01"
  description = "Ultramarines_LDN-lb01-sg01"
  vpc_id      = aws_vpc.Ultramarines_London_VPC.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   description = "HTTPS"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Ultramarines_LDN-lb01-sg01"
    Location = "London"
  }

}

