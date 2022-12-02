# -------------------------------------------------------------
# Settings exported by the module (outputs)
# -------------------------------------------------------------

output "cluster_ca" {
  value = var.enabled ? aws_eks_cluster.cluster.0.certificate_authority : null
}

output "workers_security_group_id" {
  value = var.enabled ? aws_security_group.k8s_workers_sg.0.id : null
}
output "endpoint" {
  value = var.enabled ? aws_eks_cluster.cluster.0.endpoint : null
}

output "kubeconfig-certificate-authority-data" {
  value = var.enabled ? aws_eks_cluster.cluster.0.certificate_authority.0.data : null
}