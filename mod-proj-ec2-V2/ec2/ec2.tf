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

variable "security_groups" {
    type = list(string)
    
}



resource "aws_instance" "ec2instance" {
    ami = var.ec2ami
    instance_type = var.ec2type
    tags = {
        Name = var.ec2name
    }
    ebs_optimized = var.ebs_opt
    user_data = var.user_data
    vpc_security_group_ids = var.security_groups
}




