terraform {
  backend "s3" {
    bucket = "acorales-terraform"
    key    = "infra/mod-proj-vpc-V3.tfstate"
    region = "us-east-1"
  }
}

module "vpc" {
    source = "../../modulos/vpc"
    vpcname = "vpc_module1-V3"
    vpc_cdir = "19.82.0.0/16"
    
}

output "vpc" {
    value = module.vpc.vpc
  
}

output "subnet" {
    value = module.vpc.subnet_1a
  
}

/*
output "subnet" {
    value = module.vpc.subnet_1b
  
}
*/