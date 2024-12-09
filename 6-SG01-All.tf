resource "aws_security_group" "Ultramarines_Sao_Paulo-ASG01-SG01" {
  name        = "Ultramarines_Sao_Paulo-ASG01-SG01"
  description = "Ultramarines_Sao_Paulo-ASG01-SG01"
  vpc_id      = aws_vpc.Ultramarines_Sao_Paulo_VPC.id

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
    Name    = "Ultramarines_Sao_Paulo-ASG01-SG01"
    Location = "São Paulo"
  }

}

resource "aws_security_group" "Ultramarines_Sao_Paulo-lb01-sg01" {
  name        = "Ultramarines_Sao_Paulo-lb01-sg01"
  description = "Ultramarines_Sao_Paulo-lb01-sg01"
  vpc_id      = aws_vpc.Ultramarines_Sao_Paulo_VPC.id

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

  #Theo doesn't want using port 443 yet

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Ultramarines_Sao_Paulo-lb01-sg01"
    Location = "São Paulo"
  }

}
