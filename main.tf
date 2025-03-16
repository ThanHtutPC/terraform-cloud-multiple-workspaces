terraform {
    cloud {
      organization = "workspace_1"
      workspaces {
        tags = ["env:dev"]
      }
    }
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region  = "ap-southeast-1"
    profile = "default" // Specify the AWS credentials profile
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "sn1" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.main.id
    availability_zone = "ap-southeast-1a"
}

resource "aws_security_group" "allow_ssh" {
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_ami" "ami_id" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_instance" "testing-ec2-instance" {
    ami                    = data.aws_ami.ami_id.id
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.sn1.id
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]

    tags = {
        Name = "server-${terraform.workspace}"
    }
}
