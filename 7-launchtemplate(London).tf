resource "aws_launch_template" "Ultramarines_LDN_LT" {
  provider = aws.Londres
  name_prefix   = "Ultramarines_LDN_LT"
  image_id      = "ami-0c76bd4bd302b30ec"  
  instance_type = "t2.micro"

  key_name = aws_key_pair.Ultramarines_LDN-Keypair.key_name

  vpc_security_group_ids = [aws_security_group.Ultramarines_LDN-ASG01-SG01.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd

    # Get the IMDSv2 token
    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    # Background the curl requests
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
    wait

    macid=$(cat /tmp/macid)
    local_ipv4=$(cat /tmp/local_ipv4)
    az=$(cat /tmp/az)
    vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macid/vpc-id)

    # Create HTML file
    cat <<-HTML > /var/www/html/index.html
    <!doctype html>
    <html lang="en" class="h-100">
    <head>
    <title>Details for EC2 instance</title>
    </head>
    <body>
    <div>
    <h1>Malgus Clan</h1>
    <h1>Chains Broken in London</h1>
    <p><b>Instance Name:</b> $(hostname -f) </p>
    <p><b>Instance Private Ip Address: </b> $local_ipv4</p>
    <p><b>Availability Zone: </b> $az</p>
    <p><b>Virtual Private Cloud (VPC):</b> $vpc</p>
    </div>
    </body>
    </html>
    HTML

    # Clean up the temp files
    rm -f /tmp/local_ipv4 /tmp/az /tmp/macid

    # Install rsyslog
    yum install -y rsyslog

    # Start and enable rsyslog
    systemctl start rsyslog
    systemctl enable rsyslog

    # Configure rsyslog to forward logs to the syslog server
    echo "
    *.* @@10.150.11.48:514
    " >> /etc/rsyslog.conf

    # Restart rsyslog to apply changes
    systemctl restart rsyslog

  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "Ultramarines_LDN_LT"
      
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

