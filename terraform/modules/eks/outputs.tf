output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.main.cluster_id
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS Kubernetes API server"
  value       = aws_eks_cluster.main.endpoint
}

output "node_group_name" {
    description = "NodeGroup ARN"
    value = aws_eks_node_group.main.node_group_name
}

output "eks_security_group_id" {
  description = "Security group ID for EKS cluster"
  value       = aws_security_group.eks_cluster.id
}


