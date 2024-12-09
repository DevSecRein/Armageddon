resource "tls_private_key" "Ultramarines_SP-KeyPair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "Ultramarines_SP-KeyPair" {
  private_key_pem = tls_private_key.Ultramarines_SP-KeyPair.private_key_pem
}

output "private_key-SP" {
  value     = tls_private_key.Ultramarines_SP-KeyPair.private_key_pem
  sensitive = true
}

output "public_key-SP" {
  value = data.tls_public_key.Ultramarines_SP-KeyPair.public_key_openssh
}

resource "aws_key_pair" "Ultramarines_SP-Keypair"{
  key_name = "Ultramarines_SP-Keypair"
  public_key = data.tls_public_key.Ultramarines_SP-KeyPair.public_key_openssh
}

#------------------------------------------

#NYC 

resource "tls_private_key" "Ultramarines_NYC-KeyPair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "Ultramarines_NYC-KeyPair" {
  private_key_pem = tls_private_key.Ultramarines_NYC-KeyPair.private_key_pem
}

output "private_key-NYC" {
  value     = tls_private_key.Ultramarines_NYC-KeyPair.private_key_pem
  sensitive = true
}

output "public_key-NYC" {
  value = data.tls_public_key.Ultramarines_NYC-KeyPair.public_key_openssh
}

resource "aws_key_pair" "Ultramarines_NYC-Keypair"{
  provider = aws.NovaYork
  key_name = "Ultramarines_NYC-Keypair"
  public_key = data.tls_public_key.Ultramarines_NYC-KeyPair.public_key_openssh
}

#London

resource "tls_private_key" "Ultramarines_LDN-KeyPair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "Ultramarines_LDN-KeyPair" {
  private_key_pem = tls_private_key.Ultramarines_LDN-KeyPair.private_key_pem
}

output "private_key-LDN" {
  value     = tls_private_key.Ultramarines_LDN-KeyPair.private_key_pem
  sensitive = true
}

output "public_key-LDN" {
  value = data.tls_public_key.Ultramarines_LDN-KeyPair.public_key_openssh
}

resource "aws_key_pair" "Ultramarines_LDN-Keypair"{
  provider = aws.Londres
  key_name = "Ultramarines_LDN-Keypair"
  public_key = data.tls_public_key.Ultramarines_LDN-KeyPair.public_key_openssh
}