provider "aws" {
    region = "us-east-1"
}
#variable "flavor" {
#    type = string
#    default = "t2.micro"
#}



resource "aws_instance" "instance1" {
    ami = var.amis.amazon
    instance_type = var.flavor
    tags = {
        "Name" = "Firts-Instance"
        "Environment" = var.environment[1]
    }
    ebs_optimized = var.ebs_opt
    #cpu_core_count = var.core_count

}

output "instance_public_IP" {
    value = aws_instance.instance1.public_ip
  
}

