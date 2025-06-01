variable "cluster_name" {
  description = "EKS cluster name"
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS cluster"
  type        = list(string)
}

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.29"
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  default     = 3
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  default     = 3
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  default     = 1
}

variable "node_instance_types" {
  description = "EC2 instance types for nodes"
  type        = list(string)
  default     = ["t2.small"]
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}


