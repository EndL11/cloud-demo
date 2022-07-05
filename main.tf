terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
 access_key=var.access_key
 secret_key=var.secret_key
 region=var.region
}

# Create a VPC
resource "aws_instance" "application" {
  ami			  = "ami-052efd3df9dad4825"
  instance_type  	  = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_demo.id]
  user_data              = file("init.sh")

  tags = {
  	Name = "application"
  }
}

resource "aws_security_group" "security_demo" {
	name = "security_demo"
	ingress {
	 from_port = 8080
	 protocol="TCP"
	 to_port=8080
	 cidr_blocks=["0.0.0.0/0"]
	}
	
	ingress {
	 from_port = 0
	 protocol="TCP"
	 to_port=80
	 cidr_blocks=["0.0.0.0/0"]
	}
	
	ingress {
	 from_port = 3306
	 protocol="TCP"
	 to_port=3306
	 cidr_blocks=["0.0.0.0/0"]
	}
	
	egress {
	 from_port = 0
	 protocol="-1"
	 to_port=0
	 cidr_blocks=["0.0.0.0/0"]
	}
	
	tags = {
	    Name = "Allow HTTP"
	}
}
