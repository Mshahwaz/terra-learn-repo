resource "aws_instance" "server" {
  ami = "ami-02d26659fd82cf299"

  instance_type = "t2.micro"

  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "app-server"
  }
}
