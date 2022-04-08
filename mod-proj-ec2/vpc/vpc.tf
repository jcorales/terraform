variable "vpcname" {
    type = string
}
    
variable "vpc_cdir" {
    type = string
}

variable "az" {
    type = list(string)
    default = ["us-east-1a","us-east-1b"] 
}

variable "subnet_cidr" {
    type = list(string)
    default = [ "19.82.2.0/26", "19.82.255.0/28" ]
}


variable "subnet_names" {
    type = list(string)
    default = [ "Subnet1a","Subnet1b" ]
}


resource "aws_vpc" "vpc1" {
    cidr_block = var.vpc_cdir
    tags = {
        Name = var.vpcname
    }
}




resource "aws_subnet" "subnet1a" {
    vpc_id = aws_vpc.vpc1.id
    availability_zone = var.az[0]
    cidr_block = var.subnet_cidr[0]
    tags = {
        Name = var.subnet_names[0]
    }
      
}
    

resource "aws_subnet" "subnet1b" {
    vpc_id = aws_vpc.vpc1.id
    availability_zone = var.az[1]
    cidr_block = var.subnet_cidr[1]
    tags = {
        Name = var.subnet_names[1]
    }
      
}


resource "aws_network_interface" "iface1"{
    subnet_id = aws_subnet.subnet1a.id
    private_ips = ["19.82.2.11"]
    tags = {
        Name = "subnet1-EC2" 
    }

}

resource "aws_network_interface" "iface2"{
    subnet_id = aws_subnet.subnet1b.id
    private_ips = ["19.82.255.12"]
    tags = {
        Name = "subnet2-EC2-2" 
        
    }

}

resource "aws_network_interface" "iface3"{
    subnet_id = aws_subnet.subnet1b.id
    private_ips = ["19.82.255.13"]
    tags = {
        Name = "subnet2-EC2-3" 
    }

}



##OUTPUT TO EC2-INTERFACES

output "ec2_network_interface" {
    value = aws_network_interface.iface1.id
  
}

output "ec2_network_interface-2" {
    value = aws_network_interface.iface2.id
  
}

output "ec2_network_interface-3" {
    value = aws_network_interface.iface3.id
  
}