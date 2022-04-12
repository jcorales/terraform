variable "ec2ami" {
    type = string

    default = "ami-0b0af3577fe5e3532"
}

variable "ec2type" {
    type = string

}

variable "ec2iface" {
    type = string

}


variable "ec2name" {
    type = string
    

}

variable "ebs_opt" {
    type = bool
    default = false
  
}

variable "user_data" {
    type = string
    
  
}

#variable "security_groups" {
#    type = list(string)
#    
#}

variable "key_name" {
    description = "keys to connect EC2"
    default = "ec2-apache-terraform"

    
}


resource "aws_instance" "ec2instance" {
    ami = var.ec2ami
    instance_type = var.ec2type
    key_name = var.key_name
    #security_groups = var.security_groups

    network_interface {
        network_interface_id = var.ec2iface
        device_index = 0
      
    }
    tags = {
        Name = var.ec2name
    }
    ebs_optimized = var.ebs_opt
    user_data = var.user_data
    
}




