variable "vpc_id" {
   type = string
  
}

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


output "web-app" {
    value = aws_security_group.web-app.id
}



