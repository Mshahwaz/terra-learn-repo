resource "aws_instance" "server" {
  ami = "ami-02d26659fd82cf299"

  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "app-server"
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get -qqy update && sudo apt-get -qqy upgrade
                sudo apt-get -y install nginx
                sudo systemctl start nginx
                EOF
}
