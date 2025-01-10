terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1" # change to your preferred region
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/new_id_rsa.pub") # path to your public key stored in local
}

resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow SSH from anywhere; (note: restrict for better security)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_instance" {
  ami           = "ami-05576a079321f21f8" # amazonlinux2 ami specific for us-east-1, update based on your region
  instance_type = "t2.micro"              # change instance type as needed

  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  associate_public_ip_address = true # ensure the instance gets public IP

  tags = {
    Name = "newTFEc2"
  }
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}
