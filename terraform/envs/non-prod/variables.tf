variable "env" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "clusters" {
  description = "Map of EKS cluster configurations"
  type = map(object({
    k8s_version         = string
    node_desired_size   = number
    node_instance_types = list(string)
  }))
}

# variable "rds_instances" {
#   description = "Map of RDS instance configurations"
# }

variable "name" {
  description = "Prefix for naming all resources"
  type        = string
}
