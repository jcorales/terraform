variable "vpcname" {
    type = string
}
    
variable "vpc_cdir" {
    type = string
}

variable "az" {
    type = string
}

variable "subnet_cidr" {
    type = string
}


variable "subnet_names" {
    type = string
}

variable "ec2_private_ip" {
    type = list(string)
}



resource "aws_vpc" "vpc1" {
    cidr_block = var.vpc_cdir
    tags = {
        Name = var.vpcname
    }
}


resource "aws_subnet" "subnet1a" {
    vpc_id = aws_vpc.vpc1.id
    availability_zone = var.az
    cidr_block = var.subnet_cidr
    tags = {
        Name = var.subnet_names
    }
      
}
    

resource "aws_network_interface" "iface1"{
    subnet_id = aws_subnet.subnet1a.id
    private_ips = var.ec2_private_ip
    tags = {
        Name = "Modulo VPC Network -EC2" 
    }

}

output "ec2_network_interface" {
    value = aws_network_interface.iface1.id
  
}