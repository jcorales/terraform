provider "aws" {
    region = "us-east-1"
}

module "vpc" {
    source = "./vpc"
    vpcname = "vpc_module1"
    vpc_cdir = "19.82.0.0/16"
    
}


module "ec2"    {
    source = "./ec2"
    ec2type = "t2.micro"
    ec2iface = module.vpc.ec2_network_interface
    ec2name = "instance1"

}

module "ec2-2"    {
    source = "./ec2"
    ec2type = "t2.micro"
    ec2iface = module.vpc.ec2_network_interface-2
    ec2name = "instance2"

}

module "ec2-3"    {
    source = "./ec2"
    ec2type = "t2.micro"
    ec2iface = module.vpc.ec2_network_interface-3
    ec2name = "instance3"

}
