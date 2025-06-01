variable "name" {
  description = "Prefix for naming"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "azs" {
  description = "Map of availability zones"
  type = map(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
