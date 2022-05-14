
terraform {
  backend "s3" {
    bucket = "acorales-terraform"
    key    = "infra/mod-proj-ec2-V2.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}



locals {
    ##map
    tags = { 
    "env" = "cert"
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
    
    ##boleano
    ebs_opt = true
    monitoring = true      
    
}




module "vpc" {
    source = "./vpc"
    vpcname = "vpc_module1"
    vpc_cdir = "19.82.0.0/16"
    
}



module "ec2"  {
    source = "./ec2"
    #ec2type = local.tags["type_intance"]
    ec2ami = local.instance.ami
    ec2type = local.type_intance
    ec2iface = module.vpc.ec2_network_interface
    ebs_opt = local.ebs_opt
    key_name = local.key_name
    monitoring = local.monitoring
    tags = local.tags
    user_data = <<-EOF
	        #!/bin/bash
            cd /home/ec2-user
		    echo "Hola mundo cruel" > hola.txt
		    EOF
    
}


/*
module "ec2-2"    {
    source = "./ec2"
    ec2type = "t3.micro"
    ec2iface = module.vpc.ec2_network_interface-2
    ec2name = "instance2"
    user_data = <<-EOF
	        #!/bin/bash
            sudo su
		    update -y
		    yum -y install httpd -y
		    service httpd start
		    echo "Hola mundo cruel C2 V2 $(hostname -f)" > /var/www/html/index.html
		    EOF
    
   
}

module "ec2-3"    {
    source = "./ec2"
    ec2type = "t3.micro"    
    ec2iface = module.vpc.ec2_network_interface-3
    ec2name = "instance3"
    user_data = <<-EOF
	        #!/bin/bash
		    sudo yum update -y
		    sudo yum -y install httpd -y
		    sudo service httpd start
		    echo "Hello world from EC2 V2 $(hostname -f)" > /var/www/html/index.html
		    EOF
    

}

*/

output "tags" {
    value = module.ec2.test
  
}

