provider "aws" {
    region = "us-east-1"
}

module "vpc" {
    source = "./vpc"
    vpcname = "vpc_module1"
    vpc_cdir = "19.82.0.0/16"
    
}

#module "sg" {
#    source = "./sg"
#    
#}


module "ec2"  {
#  depends_on = [
#    module.sg
#  ]
  ###
    source = "./ec2"
    ec2type = "t3.micro"
    ec2iface = module.vpc.ec2_network_interface
    #security_groups = ["module.sg.web-app.id"]
    ec2name = "instance1"
    user_data = <<-EOF
	        #!/bin/bash
		    echo "Hola mundo cruel"
		    EOF
    
}

module "ec2-2"    {
    source = "./ec2"
    ec2type = "t2.micro"
    ec2iface = module.vpc.ec2_network_interface-2
    #security_groups = ["module.sg.aws_security_group.web-app"]
    ec2name = "instance2"
    user_data = <<-EOF
	        #!/bin/bash
		    sudo yum update -y
		    sudo yum -y install httpd -y
		    sudo service httpd start
		    echo "Hola mundo cruel C2 V2 $(hostname -f)" > /var/www/html/index.html
		    EOF
    
   
}

module "ec2-3"    {
    source = "./ec2"
    ec2type = "t2.micro"    
    ec2iface = module.vpc.ec2_network_interface-3
    #security_groups = ["module.sg.aws_security_group.web-app"]
    ec2name = "instance3"
    user_data = <<-EOF
	        #!/bin/bash
		    sudo yum update -y
		    sudo yum -y install httpd -y
		    sudo service httpd start
		    echo "Hello world from EC2 V2 $(hostname -f)" > /var/www/html/index.html
		    EOF
    

}





