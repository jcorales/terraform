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
data "terraform_remote_state" "networking" {
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
      ##put prod, cert or dev## 
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
    subnet_id = data.terraform_remote_state.networking.outputs.subnet.id
        
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
    vpc_id = data.terraform_remote_state.networking.outputs.vpc.id
    #vpc_id = "vpc-0d4ded125a43f2358"
  
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
    #count = 2
    tags = local.tags
    /*
    user_data = <<-EOF
	        #!/bin/bash
            cd /home/ec2-user
		    echo "Hola mundo cruel" > hola.txt
		    EOF
    */    
    user_data = file("${path.module}/app1-install.sh")
    /*count = 2
    tags = {
      "Name" = "local.tags-${count.index}"
*/
    
}

output "vpc" {
  value = data.terraform_remote_state.networking.outputs.vpc.id
}




output "subnet" {
  value = data.terraform_remote_state.networking.outputs.subnet.id

}