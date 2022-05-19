variable "vpcname" {
    type = string
    #default = "acorales-v3"
}
    
variable "vpc_cdir" {
    type = string
    #default = "19.82.0.0/16"
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

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_default_route_table" "route_ig" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "IG"
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

output "vpc" {
    value = aws_vpc.vpc1.id
  
}