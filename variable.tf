# vpc variables
variable "vpc_cidr" {
    default          = "10.0.0.0/16" 
    description      = "vpc cidr block"
    type             = string
}

variable "public_subnet_az1_cidr" {
    default          = "10.0.0.0/24" 
    description      = "public subnet az1 cidr block"
    type             = string
}

variable "public_subnet_az2_cidr" {
    default          = "10.0.1.0/24" 
    description      = "public subnet az2 cidr block"
    type             = string
}

variable "private_subnet_az1_cidr" {
    default          = "10.0.2.0/24" 
    description      = "private subnet az1 cidr block"
    type             = string
}

variable "private_subnet_az2_cidr" {
    default          = "10.0.3.0/24" 
    description      = "private subnet az2 cidr block"
    type             = string
}

variable "region-name" {
    default          = "eu-west-2" 
    description      = "name of region"
    type             = string
}

variable "project-name" {
    default          = "aws-3tier" 
    description      = "name of project"
    type             = string
}
variable "instance-type" {
    default          = "t2.micro" 
    description      = "type of instance"
    type             = string
}


