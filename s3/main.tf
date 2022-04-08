/*
terraform {
  required_providers {
    aws = {
      version = "= 4.8.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 0.13.5"
}

*/

provider "aws" {
    region = var.aws_region[0]
      
}


resource "aws_s3_bucket" "webtest1" {
    bucket = var.bucket_name

  # ... other configuration ...
}

resource "aws_s3_bucket_acl" "bucket_acl" {
    bucket = aws_s3_bucket.webtest1.id
    acl = "public-read"
}   

resource "aws_s3_object" "object1" {
    bucket = aws_s3_bucket.webtest1.id
    #source = var.content
    key = "index.html"
    acl = "public-read"
    content = var.content
    content_type = "text/html"
}


resource "aws_s3_bucket_website_configuration" "webtest1_config" {
    bucket = aws_s3_bucket.webtest1.id



    index_document {
        suffix = "index.html"
    }

/*
    error_document {
        key = "error.html"
    }

    routing_rule {
        condition {
        key_prefix_equals = "docs/"
        }
        redirect {
        replace_key_prefix_with = "documents/"
        }
    }
*/

}






