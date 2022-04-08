
variable "flavor" {
    type = string
    default = "t3.small"
}

variable "ebs_opt" {
    type = bool
    default = false
  
}

variable "cpu_core_count" {
    type = number
    default = 1
  
}

variable "environment" {
    type = list(string)
    default = ["dev","test","pro"]
  
}

variable "amis" {
    type = map
    default = {
        "amazon" = "ami-0c02fb55956c7d316"
        "mac" = "ami-09b4af2619e2e8db0"
        "redhat" = "ami-0b0af3577fe5e3532"
    }
}


