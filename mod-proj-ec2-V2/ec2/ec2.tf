variable "ec2ami" {
    type = string
}

variable "ec2type" {
    type = string

}

variable "ec2iface" {
    type = string

}



variable "ebs_opt" {
    type = bool
    default = false
  
}

variable "user_data" {
    type = string
    
  
}

variable "key_name" {
    description = "keys to connect EC2"
    default = "ec2-apache-terraform"

    
}

variable "tags" {
    type = map(string)
    
  
}

locals {
    tagname = { 
        Name = "ec2-${var.tags["team"]}-${var.tags["app"]}-${var.tags["env"]}"
    }
}


resource "aws_instance" "ec2instance" {
    ami = var.ec2ami
    instance_type = var.ec2type
    key_name = var.key_name
    network_interface {
        network_interface_id = var.ec2iface
        device_index = 0

    }
    tags = merge(var.tags,local.tagname)

    ebs_optimized = var.ebs_opt
    user_data = var.user_data
    
}



   


resource "aws_eip" "public_ip" {
  instance = aws_instance.ec2instance.id
  vpc      = true
}

output "test" {
  value = merge(var.tags,local.tagname)
}