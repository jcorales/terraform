variable "aws_region" {
    type = string
    default = "us-east-1"
  
}

variable "vpc_cdir" {
  type = string
  default = "192.168.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "vpc_practice1"
}

variable "subnet_cidr" {
  type = list(string)
  default = ["192.168.1.0/24","192.168.2.0/24", "192.168.3.0/24"]
}
variable "az" {
    type = list(string)
    default = ["us-east-1a", "eu-north-1a", "eu-north-1b"]
  
}

variable "subnet_name" {
    type = list(string)
    default = ["subnet1", "subnet2", "subnet3"]
  
}