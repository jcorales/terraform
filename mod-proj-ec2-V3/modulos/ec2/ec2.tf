variable "ec2ami" {
    type = string
}

variable "ec2type" {
    type = string

}




variable "subnet_id" {
    type = string

}


variable "ebs_optimized" {
    type = bool
    default = false
  
}


variable "vpc_security_group_ids" {
    type = list(string)
    #default = "sg-0c24c6da530e20da4"
  
}



variable "monitoring" {
    type = bool
    default = false
  
}


variable "user_data" {
    type = string
    
  
}

variable "key_name" {
    description = "keys to connect EC2"
    type = string
    
}


variable "tags" {
    type = map(string)
    
  
}

variable "instance_tag" {
    type = string
    default = "prod"
    
  
}

locals {
    tagname = { 
        Name = "ec2-${var.tags["team"]}-${var.tags["app"]}-${var.tags["env"]}"
    }
}

/*
resource "null_resource" "tags_name" {
  triggers = {
    some_name  = local.tagname
  }
}
*/

locals {
  foobar_default = local.tagname.Name == null ? "default value for foo.foobar" : local.tagname.Name
}



resource "aws_instance" "ec2instance" {
    ami = var.ec2ami
    instance_type = var.tags.env == "dev" ? "t2.micro" : ( var.tags.env == "cert" ? "t2.small" : ( "t3.micro"  ))
    key_name = var.key_name
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
    monitoring = true
    user_data = var.user_data
    ebs_optimized = var.ebs_optimized
    count = 2
    tags = {
      Name = local.foobar_default
    
    }  
    
}





#resource "aws_eip" "public_ip" {
#  instance = aws_instance.ec2instance[*].id
#  vpc      = true
#}




# EC2 Instance Public DNS
#output "instance_publicdns" {
#  description = "EC2 Instance Public DNS"
#  value = aws_instance.ec2instance.public_dns
#}


output "test" {
  value = merge(var.tags,local.tagname)
}

