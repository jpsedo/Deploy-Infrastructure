# --------------------------------------------------------------------
# IAM Policies and Roles for EKS
# --------------------------------------------------------------------

## Role and policies needed by the K8S masters
resource "aws_iam_role" "k8s_masters_role" {
  count              = var.enabled ? 1 : 0
  name               = "k8s_masters_role_${var.cluster_name}"
  assume_role_policy = <<EOP
{
  "Version": "2012-10-17",
  "Statement": [
   {
     "Effect": "Allow",
     "Principal": {
        "Service": "eks.amazonaws.com"   
     },
     "Action": "sts:AssumeRole"  
   }     
  ]    
}
EOP
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  count      = var.enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = var.enabled ? aws_iam_role.k8s_masters_role.0.name : ""
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  count      = var.enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = var.enabled ? aws_iam_role.k8s_masters_role.0.name : ""
}

## Role and policies needed by the K8S workers
resource "aws_iam_role" "k8s_workers_role" {
  count              = var.enabled ? 1 : 0
  name               = "k8s_workers_role_${var.cluster_name}"
  assume_role_policy = <<EOP
{
  "Version": "2012-10-17",
  "Statement": [
   {
    "Effect": "Allow",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
   }
  ]
}
EOP
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  count      = var.enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  count      = var.enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  count      = var.enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

resource "aws_iam_instance_profile" "iam_workers_profile" {
  count = var.enabled ? 1 : 0
  name  = "k8s_workers_profile_${var.cluster_name}"
  role  = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

## Policy to allow the K8S cluster auto-scaler feature to adjust the size of an ASG
data "aws_iam_policy_document" "autoscaling_policy" {
  count = var.enabled ? 1 : 0
  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}
resource "aws_iam_policy" "autoscaling_policy" {
  count       = var.enabled ? 1 : 0
  name        = "k8s-autoscaler-policy_${var.cluster_name}"
  description = "Allows K8S cluster auto-scaler to adjust the ASG size"
  policy      = var.enabled ? data.aws_iam_policy_document.autoscaling_policy.0.json : ""
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "attach_autoscaling_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = var.enabled ? aws_iam_policy.autoscaling_policy.0.arn : ""
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

## Allows K8S cluster to create ingress loadbalancers
resource "aws_iam_policy" "aws_iam_policy_loadbalancer_controller" {
  count       = var.enabled ? 1 : 0
  name        = "AWSLoadBalancerControllerIAMPolicy_${var.cluster_name}"
  description = "Allows K8S cluster to create ingress loadbalancers"
  policy      = file("${path.module}/policies/ingress.json")
  tags        = var.tags
}
resource "aws_iam_role_policy_attachment" "attach_ingress_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = var.enabled ? aws_iam_policy.aws_iam_policy_loadbalancer_controller.0.arn : ""
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

## Allows K8S cluster to access aws secrets manager
resource "aws_iam_policy" "aws_iam_policy_secrets_manager" {
  count       = var.enabled ? 1 : 0
  name        = "AWSSecretsManagerIAMPolicy_${var.cluster_name}"
  description = "Allows K8S cluster to access secrets manager"
  policy      = file("${path.module}/policies/secretsmanager.json")
  tags        = var.tags
}
resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = var.enabled ? aws_iam_policy.aws_iam_policy_secrets_manager.0.arn : ""
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

## Allows K8S cluster to cognito user pool
resource "aws_iam_policy" "aws_iam_policy_cognito" {
  count       = var.enabled ? 1 : 0
  name        = "AWSCognitoIAMPolicy_${var.cluster_name}"
  description = "Allows K8S cluster to access cognito"
  policy      = file("${path.module}/policies/cognito.json")
  tags        = var.tags
}
resource "aws_iam_role_policy_attachment" "attach_cognito_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = var.enabled ? aws_iam_policy.aws_iam_policy_cognito.0.arn : ""
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

# resource "aws_iam_role_policy_attachment" "attach_ingress_policy_to_masters" {
#   policy_arn = aws_iam_policy.aws_iam_policy_loadbalancer_controller.arn
#   role = aws_iam_role.k8s_masters_role.name
# }

## Allows K8S cluster to create dns records on Route53
resource "aws_iam_policy" "aws_iam_policy_external_dns" {
  count       = var.enabled ? 1 : 0
  name        = "AWSExternalDnsIAMPolicy_${var.cluster_name}"
  description = "Allows K8S cluster to create dns records on Route53"
  policy      = file("${path.module}/policies/route53.json")
  tags        = var.tags
}
resource "aws_iam_role_policy_attachment" "attach_external_dns_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = var.enabled ? aws_iam_policy.aws_iam_policy_external_dns.0.arn : ""
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}

## Allows K8S cluster to create and push los to Cloudwatchter
resource "aws_iam_policy" "aws_iam_policy_cloudwatch" {
  count       = var.enabled ? 1 : 0
  name        = "AWSCloudWatchIAMPolicy_${var.cluster_name}"
  description = "Allows K8S cluster to create dns records on Route53"
  policy      = file("${path.module}/policies/cloudwatch.json")
  tags        = var.tags
}
resource "aws_iam_role_policy_attachment" "attach_cloudwatch_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = var.enabled ? aws_iam_policy.aws_iam_policy_cloudwatch.0.arn : ""
  role       = var.enabled ? aws_iam_role.k8s_workers_role.0.name : ""
}
