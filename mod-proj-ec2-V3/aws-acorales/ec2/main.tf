terraform {
  backend "s3" {
    bucket = "acorales-terraform"
    key    = "infra/mod-proj-ec2-V3.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}

###state remote from VPC
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "acorales-terraform"
    key    = "infra/mod-proj-vpc-V3.tfstate"
    region = "us-east-1"
  }
}


locals {
    ##map
    tags = { 
    "env" = "prod"
    "team" = "admin"
    "app" = "tarjetas"
    }
    instance = {
    "ami" = "ami-0c02fb55956c7d316"
    }
    ##Operador condicional (ternario)
    type_intance = true


    #string
    key_name = "ec2-apache-terraform"
    subnet_id = "subnet-08483c74a3fbc9902"
        
    ##boleano
    ebs_optimized = true
    monitoring = true      
    
}


/* ###
module "sg" {
    source = "../../modulos/sg"
    vpc_name = "vpc_module1-V3"
  
}
*/

module "sg" {
    source = "../../modulos/sg"
    vpc_name = "vpc_module1-V3"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc.vpc
  
}


module "ec2"  {
    source = "../../modulos/ec2"
    #ec2type = local.tags["type_intance"]
    ec2ami = local.instance.ami
    ec2type = local.type_intance
    subnet_id = local.subnet_id
    vpc_security_group_ids = [module.sg.web-id,module.sg.ssh-id]
    ebs_optimized = local.ebs_optimized
    key_name = local.key_name
    monitoring = local.monitoring
    tags = local.tags
    user_data = <<-EOF
	        #!/bin/bash
            cd /home/ec2-user
		    echo "Hola mundo cruel" > hola.txt
		    EOF
    
}


output "vpc" {
  value = data.terraform_remote_state.vpc.outputs.vpc.vpc
}