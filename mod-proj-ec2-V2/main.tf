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
    source = "./ec2"
    ec2type = "t2.micro"
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
		    echo "Hello world from EC2 $(hostname -f)" > /var/www/html/index.html
		    EOF
    security_groups = [module.sg.sg_attachment-subnet1b]
    
}

// ##### SUBEEEEEEE EL CODIGOOO A UN REPOOOOOOOOOOOOO, no puedo trabaaar en esta maquina , si lo subes es mas //  facil trabajar los doss , con el codigo versionado  en un repo ya te habria marcado que era lo que estaba mal en  el codigo  , ahora tenes un conflicto network_interface y security group ,seguramente tenes que agregar el security group dentro de la net
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
		    echo "Hello world from EC2 $(hostname -f)" > /var/www/html/index.html
		    EOF
    security_groups = [module.sg.sg_attachment-subnet1b]

}





