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
    default = [ "19.82.2.0/26", "19.83.255.0/27", "19.84.3.0/28", "19.85.255.0/29" ,"19.86.4.0/30", "19.87.255.0/32" ] ]
}


variable "subnet_names" {
    type = list(string)
    default = [ "Subnet1a","Subnet1b","Subnet1c","Subnet1d","Subnet1e","Subnet1f" ]
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


# Availability Zones Datasource
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


resource "aws_subnet" "subnet1a" {
    vpc_id = aws_vpc.vpc1.id
    for_each = toset(data.aws_availability_zones.my_azones.names)
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
    value = aws_vpc.vpc1
  
}

output "subnet_1a" {
    value = aws_subnet.subnet1a
  
}




output "aws_availability_zones" {
    value = data.aws_availability_zones.my_azones.names
  
}
