provider "aws" {
    region = "us-east-1"
}

module "vpc" {
    source = "./vpc"
    vpcname = "vpc_module1"
    vpc_cdir = "19.82.0.0/16"
    
}

module "sg" {
    source = "./sg"      
    
}


module "ec2"  {
  depends_on = [
    module.sg
  ]
  ###
    source = "./ec2"
    ec2type = "t3.micro"
    ec2iface = module.vpc.ec2_network_interface
    ec2name = "instance1"
    user_data = <<-EOF
	        #!/bin/bash
		    echo "Hola mundo cruel"
		    EOF
    security_groups = [module.sg.sg_attachment-subnet1b]
}

module "ec2-2"    {
    source = "./ec2"
    ec2type = "t2.micro"
    ec2iface = module.vpc.ec2_network_interface-2
    ec2name = "instance2"
    user_data = <<-EOF
	        #!/bin/bash
		    sudo yum update -y
		    sudo yum -y install httpd -y
		    sudo service httpd start
		    echo "Hola mundo cruel C2 V2.2 $(hostname -f)" > /var/www/html/index.html
		    EOF
    security_groups = [module.sg.sg_attachment-subnet1b]
    
}

module "ec2-3"    {
    source = "./ec2"
    ec2type = "t2.micro"    
    ec2iface = module.vpc.ec2_network_interface-3
    
    ec2name = "instance3"
    user_data = <<-EOF
	        #!/bin/bash
		    sudo yum update -y
		    sudo yum -y install httpd -y
		    sudo service httpd start
		    echo "Hello world from EC2 V2.1 $(hostname -f)" > /var/www/html/index.html
		    EOF
    security_groups = [module.sg.sg_attachment-subnet1b]

}





