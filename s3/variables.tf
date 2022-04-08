variable "aws_region" {
    type = list(string)
    default = ["us-east-1", "eu-north-1"]
  
}


variable "bucket_name" {
    type = string
    default = "webtest1-acoralescelisxxxxxxtgtg"

  
}

variable "content" {
    type = string

  
}