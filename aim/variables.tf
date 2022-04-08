variable "aws_region" {
    type = list(string)
    default = ["us-east-1", "eu-north-1"]
  
}

variable "user1" {
    type = string
    default = "user1"
  
}

variable "policyname1" {
    type = string
    default = "policy_s3_listAllMyBuckets"
  
}