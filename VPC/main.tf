provider "aws" {
    region = var.aws_region
  
}

resource "aws_vpc" "vpc1_terraform" {
  cidr_block       = var.vpc_cdir
  #instance_tenancy = "default"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc1_terraform.id
  cidr_block = var.subnet_cidr[0]
  ##Clocamos AZ sin valor - declarar variable
  availability_zone = var.az[0]
  tags = {
    Name = var.subnet_name[0]
  }
}

/*
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_cidr[1]
  ##Clocamos AZ sin valor - declarar variable
  avavailability_zone = var.subnet_cidr[1]
  tags = {
    Name = var.subnet2
  }
}
*/

  
