terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }

  }
  required_version = ">= 1.2"
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "server" {
  ami = "ami-02d26659fd82cf299"

  instance_type               = "t2.micro"
  vpc_security_group_ids = [ data.aws_security_group.aws-sg.id ]
  subnet_id                   = data.aws_subnet.name.id
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



output "ip-address" {
  value = aws_instance.server.public_ip
}



data "aws_vpc" "my-vpc" {
  tags = {
    Name = "my-vpc"
  }
}

output "my-vpc-id" {
  value = data.aws_vpc.my-vpc.id

}

data "aws_security_group" "aws-sg" {
  tags = {
    Name = "my-sg"
  }
}

data "aws_subnet" "name" {
  vpc_id = data.aws_vpc.my-vpc.id

  tags = {
    Name = "my-public-subnet"
  }
}

output "subnet" {
  value = data.aws_subnet.name.id
}



output "sg-id" {
  value = data.aws_security_group.aws-sg.id
}