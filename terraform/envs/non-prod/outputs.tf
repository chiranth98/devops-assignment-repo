# output "node_group_name" {
#   value = module.eks_node_group.node_group_name
# }
output "eks_security_group_id" {
  value = module.eks["cluster1"].eks_security_group_id
}

