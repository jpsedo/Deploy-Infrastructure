# --------------------------------------------------------------------
# Security Groups settings for EKS (masters & workers)
# --------------------------------------------------------------------

## Security Group for ENI created for the K8S Control Plane
resource "aws_security_group" "k8s_masters_sg" {
  count       = var.enabled ? 1 : 0
  description = "Managed by Terraform"
  name        = "${var.cluster_name}_masters_sg"
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { "Name" = "${var.cluster_name}_masters_sg" })
}
resource "aws_security_group_rule" "outbound_traffic_masters_sg" {
  count             = var.enabled ? 1 : 0
  description       = "Allow outbound traffic from K8S masters"
  type              = "egress"
  protocol          = -1
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.enabled ? aws_security_group.k8s_masters_sg.0.id : ""
}
resource "aws_security_group_rule" "workers_inbound_443_traffic_masters_sg" {
  count                    = var.enabled ? 1 : 0
  description              = "Allow inbound traffic to the K8S API from K8S workers SG. External traffic to the K8S API is allowed by default and controlled by AWS"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = var.enabled ? aws_security_group.k8s_workers_sg.0.id : ""
  security_group_id        = var.enabled ? aws_security_group.k8s_masters_sg.0.id : ""
}
resource "aws_security_group_rule" "public_inbound_443_traffic_masters_sg" {
  description       = "Allow inbound traffic to the K8S API from specific public IPs, if any"
  count             = var.enabled ? length(var.allowed_ips_k8s_api_access) : 0
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [element(var.allowed_ips_k8s_api_access, count.index)]
  security_group_id = var.enabled ? aws_security_group.k8s_masters_sg.0.id : ""
}


## Security Group for K8S Workers
resource "aws_security_group" "k8s_workers_sg" {
  count       = var.enabled ? 1 : 0
  description = "Managed by Terraform"
  name        = "${var.cluster_name}_workers_sg"
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { "Name" = "${var.cluster_name}_workers_sg" })
}
resource "aws_security_group_rule" "outbound_traffic_workers_sg" {
  count             = var.enabled ? 1 : 0
  description       = "Allow outbound traffic from K8S nodes"
  type              = "egress"
  protocol          = -1
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.enabled ? aws_security_group.k8s_workers_sg.0.id : ""
}
resource "aws_security_group_rule" "self_traffic_workers_sg" {
  count             = var.enabled ? 1 : 0
  description       = "Allow communication between K8s nodes"
  type              = "ingress"
  protocol          = -1
  from_port         = 0
  to_port           = 65535
  self              = true
  security_group_id = var.enabled ? aws_security_group.k8s_workers_sg.0.id : ""
}
resource "aws_security_group_rule" "masters_inbound_traffic_workers_sg" {
  count                    = var.enabled ? 1 : 0
  description              = "Allow inbound traffic from the K8S API"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 1024
  to_port                  = 65535
  source_security_group_id = var.enabled ? aws_security_group.k8s_masters_sg.0.id : ""
  security_group_id        = var.enabled ? aws_security_group.k8s_workers_sg.0.id : ""
}
resource "aws_security_group_rule" "app_inbound_traffic_workers_sg" {
  count             = var.enabled ? length(var.allow_app_ports) : 0
  description       = "Allow inbound traffic to specific App ports from instances the VPC"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = element(var.allow_app_ports, count.index)
  to_port           = element(var.allow_app_ports, count.index)
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = var.enabled ? aws_security_group.k8s_workers_sg.0.id : ""
}