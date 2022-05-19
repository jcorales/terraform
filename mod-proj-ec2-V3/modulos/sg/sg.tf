variable "vpc_name" {
   type = string
  
}
variable "vpc_id" {
   type = string
  
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}



###intance 1 subnet 1a
resource "aws_security_group" "ssh" {
  name        = "SSH"
  description = "SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }
  
  tags = {
    Name = "SSH"
  }
}



##intances 2 y 3 subnet 1b
resource "aws_security_group" "web-app" {
   name   = "web-app"
   description = "security_group"
   vpc_id = var.vpc_id

   ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
      description = "ingress_rule_2"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
      description = "ingress_rule_3"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   
   egress {
      description = "ingress_rule_4"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }   

   tags = {
      Name = "web-app"
   }
}


##

output "web-id" {
    value = aws_security_group.web-app.id
}


output "ssh-id" {
    value = aws_security_group.ssh.id
}



