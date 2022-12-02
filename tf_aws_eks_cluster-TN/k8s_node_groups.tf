resource "aws_eks_cluster" "cluster" {
  count    = var.enabled ? 1 : 0
  name     = var.cluster_name
  role_arn = var.enabled ? aws_iam_role.k8s_masters_role.0.arn : ""
  version  = "1.19"
  vpc_config {
    #
    # The subnet IDs where ENIs will be placed for communication between masters and nodes.
    # If placed in private subnets, K8S will not be able to find public subnets for deploying
    # 'LoadBalancer' services for workloads. These ENIs are assigned with private IPs only,
    # even when they are in public subnets. 
    subnet_ids = concat(var.public_subnets_ids, var.private_subnets_ids)
    #
    # The security group to attach to the EKS ENIs. Only traffic between master and nodes is allowed.
    security_group_ids      = [aws_security_group.k8s_masters_sg.0.id]
    endpoint_private_access = true
    ## temp_tfsec:ignore:AWS069:Public access to the EKS API is enabled as no VPN is in place, and you need a kubeconfig or creds to obtain it to access to the cluster
    endpoint_public_access = true
    ## temp_tfsec:ignore:AWS068:Internet access is allowed as no specific CIDR ranges can be defined
    public_access_cidrs = ["0.0.0.0/0"]

    # dynamic "encryption_config" {
    #   for_each = var.kms_key_arn ? [1] : []
    #   content {
    #     resources = [ "secrets" ]
    #     provider {
    #       key_arn = var.kms_key_arn
    #     }
    #   }
    # }
  }
  enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]
  tags = var.tags
}

resource "aws_eks_node_group" "eks-node-group" {
  count           = var.enabled ? 1 : 0
  cluster_name    = var.enabled ? aws_eks_cluster.cluster.0.name : null
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.enabled ? aws_iam_role.k8s_workers_role.0.arn : ""
  subnet_ids      = flatten([var.private_subnets_ids])
  disk_size       = var.boot_volume_size
  instance_types  = [var.workers_instance_type]
  scaling_config {
    desired_size = var.asg_desired_size
    max_size     = var.asg_max_size
    min_size     = var.asg_min_size
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
  tags = merge(
    var.tags, {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      "Name"                                      = var.cluster_name
  })
}