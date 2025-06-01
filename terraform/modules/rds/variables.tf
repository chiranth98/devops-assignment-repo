variable "name" {
  type        = string
  description = "Prefix for naming"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "eks_security_group_id" {
  type        = string
  description = "Security group ID for EKS cluster"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}

variable "databases" {
  type = map(object({
    username = string
    password = string
  }))
  description = "Map of database configurations"
}
