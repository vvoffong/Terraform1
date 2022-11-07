terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"  
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

variable "environment" {
  description = "name of environment"
}

variable "availability_zone" {
  description = "name of availability zone" 
}
resource "aws_vpc" "development-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: "development",
        Terraform: "true"
        Environment: var.environment 
    }
} 

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
      Name: "subnet-1-dev",
      Terraform: "true",
      Environment: var.environment
    }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}