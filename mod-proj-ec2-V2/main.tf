
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


module "vpc" {
    source = "./vpc"
    vpcname = "vpc_module1"
    vpc_cdir = "19.82.0.0/16"
    
}

module "ec2"  {
    source = "./ec2"
    ec2type = "t3.small"
    ec2iface = module.vpc.ec2_network_interface
    ec2name = "instance1"
    user_data = <<-EOF
	        #!/bin/bash
            cd /home/ec2-user
		    echo "Hola mundo cruel" > hola.txt
		    EOF
    
}

module "ec2"  {
    source = "./ec2"
    ec2type = "t3.small"
    ec2iface = module.vpc.ec2_network_interface
    ec2name = "instance1"
    user_data = <<-EOF
	        #!/bin/bash
            cd /home/ec2-user
		    echo "Hola mundo cruel" > hola.txt
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





