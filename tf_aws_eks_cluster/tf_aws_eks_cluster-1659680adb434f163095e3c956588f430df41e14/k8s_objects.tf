## Terraform provider for Kubernetes does not support the EKS  
## authentication method yet (credentials plugin 'exec' feature).
## We create kube objects using null_resources for now.

# --------------------------------------------------------------------
# kubeconfig file
# --------------------------------------------------------------------

## generate a template for the kubeconfig file as kubernetes provider does not support variables as alias
data "template_file" "kubeconfig" {
  count    = var.enabled ? 1 : 0
  template = file("${path.module}/templates/kubeconfig.yaml.tpl")
  vars = {
    cluster_name     = var.cluster_name
    cluster_endpoint = var.enabled ? aws_eks_cluster.cluster.0.endpoint : ""
    cluster_cert     = var.enabled ? aws_eks_cluster.cluster.0.certificate_authority.0.data : ""
    aws_profile      = var.aws_profile
    aws_region       = var.aws_region
  }
}

## generate a local file from the rendered template, to be used by TF to deploy kube objects
resource "local_file" "kubeconfig" {
  count    = var.enabled ? 1 : 0
  content  = var.enabled ? data.template_file.kubeconfig.0.rendered : ""
  filename = pathexpand("${var.kube_folder_path}/config_${var.cluster_name}")
}

# --------------------------------------------------------------------
# aws-auth ConfigMap
# --------------------------------------------------------------------

## generate templates mapping IAM users with cluster users/groups
data "template_file" "map_users" {
  count    = var.enabled ? length(var.map_users) : 0
  template = file("${path.module}/templates/aws-auth_map-users.yaml.tpl")
  vars = {
    user_arn = lookup(var.map_users[count.index], "user_arn")
    username = lookup(var.map_users[count.index], "username")
    group    = lookup(var.map_users[count.index], "group")
  }
}

## generate a template for aws-auth ConfigMap, adding the ones created above
data "template_file" "aws_auth_config_map" {
  count    = var.enabled ? 1 : 0
  template = file("${path.module}/templates/aws-auth_config-map.yaml.tpl")
  vars = {
    workers_role_arn = var.enabled ? aws_iam_role.k8s_workers_role.0.arn : ""
    map_users        = join("", data.template_file.map_users.*.rendered)
  }
}

## generate a local file from the final/rendered aws-auth ConfigMap
resource "local_file" "config_map_aws_auth" {
  count    = var.enabled ? 1 : 0
  content  = var.enabled ? data.template_file.aws_auth_config_map.0.rendered : ""
  filename = pathexpand("${var.kube_folder_path}/aws_auth_configmap_${var.cluster_name}.yaml")
}

## deploy the aws-auth ConfigMap
resource "null_resource" "deploy_aws_auth_cm" {
  count = var.enabled ? 1 : 0
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.kube_folder_path}/aws_auth_configmap_${var.cluster_name}.yaml --kubeconfig ${local_file.kubeconfig.0.filename}"
  }
  triggers = {
    content = local_file.config_map_aws_auth.0.content
  }
  # depends_on = ["aws_autoscaling_group.workers_asg", "local_file.config_map_aws_auth", "local_file.kubeconfig.0"]
}

# --------------------------------------------------------------------
# Service Accounts & Roles
# --------------------------------------------------------------------

## SA for Tiller scoped in the kube-system namespace (server side of Helm)
resource "null_resource" "tiller_service_account" {
  count = var.enabled ? 1 : 0
  provisioner "local-exec" {
    command = "kubectl create serviceaccount tiller --namespace kube-system --kubeconfig ${local_file.kubeconfig.0.filename}"
  }
  depends_on = [null_resource.deploy_aws_auth_cm]
}

## grant 'cluster-admin' ClusterRole to the Tiller service account
resource "null_resource" "tiller_service_account_role" {
  count = var.enabled ? 1 : 0
  provisioner "local-exec" {
    command = "kubectl create clusterrolebinding tiller-cluster-admin-role --clusterrole=cluster-admin --serviceaccount=kube-system:tiller --kubeconfig ${local_file.kubeconfig.0.filename}"
  }
  depends_on = [null_resource.tiller_service_account]
}

# --------------------------------------------------------------------
# RBAC custom roles
# --------------------------------------------------------------------

## ClusterRole allowing read-only access to some kube objects   
resource "local_file" "ro_cluster_role" {
  count    = var.enabled ? 1 : 0
  filename = pathexpand("${var.kube_folder_path}/rbac_ro_role.yaml")
  content  = <<EOP

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: read-only
rules:
- apiGroups: [""]
  resources: [ "nodes", "namespaces", "pods", "pods/log", "pods/status", "configmaps", "services" ] 
  verbs: [ "get", "list", "watch" ]
- apiGroups: ["apps"]
  resources: [ "daemonsets", "deployments" ]
  verbs: [ "get", "list", "watch" ]
- apiGroups: ["extensions"]
  resources: [ "daemonsets", "deployments", "ingresses" ]
  verbs: [ "get", "list", "watch" ]

EOP
}

## deploy the ClusterRole file created above
resource "null_resource" "deploy_ro_cluster_role" {
  count = var.enabled ? 1 : 0
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.kube_folder_path}/rbac_ro_role.yaml --kubeconfig ${local_file.kubeconfig.0.filename}"
  }

  triggers = {
    content = local_file.ro_cluster_role.0.content
  }

  depends_on = [local_file.ro_cluster_role, local_file.kubeconfig.0]
}

## Bind the ClusterRole 'read-only' to a group named 'ReadOnlyGroup'
resource "local_file" "ro_role_binding" {
  count    = var.enabled ? 1 : 0
  filename = pathexpand("${var.kube_folder_path}/rbac_ro_role_binding.yaml")
  content  = <<EOP

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: read-only-global
subjects:
- kind: Group
  name: ReadOnlyGroup
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: read-only
  apiGroup: rbac.authorization.k8s.io

EOP
}

## deploy the ClusterRoleBinding file created above
resource "null_resource" "deploy_ro_role_binding" {
  count = var.enabled ? 1 : 0
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.kube_folder_path}/rbac_ro_role_binding.yaml --kubeconfig ${local_file.kubeconfig.0.filename}"
  }
  triggers = {
    content = local_file.ro_role_binding.0.content
  }
  depends_on = [null_resource.deploy_ro_cluster_role, local_file.ro_role_binding, local_file.kubeconfig.0]
}

provider "helm" {
  kubernetes {
    config_path = var.enabled ? pathexpand(local_file.kubeconfig.0.filename) : ""
  }
}

## -------------------------------------
## AWS LOAD BALANCER CONTROLLER 
## ------------------------------------

resource "null_resource" "TargetGroupBinding" {
  count      = var.enabled ? 1 : 0
  depends_on = [local_file.kubeconfig.0]
  provisioner "local-exec" {
    command = "kubectl apply -k github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master --kubeconfig ${local_file.kubeconfig.0.filename}"
  }
}

resource "helm_release" "aws-load-balancer-controller" {
  count        = var.enabled ? 1 : 0
  depends_on   = [local_file.kubeconfig.0]
  name         = "aws-load-balancer-controller"
  repository   = "https://aws.github.io/eks-charts"
  chart        = "aws-load-balancer-controller"
  namespace    = "kube-system"
  reuse_values = true
  set {
    name  = "vpcId"
    value = var.vpc_id
  }
  # set {
  #   name  = "serviceAccount.name"
  #   value = "aws-load-balancer-controller"
  # }
  set {
    name  = "serviceAccount.create"
    value = "false"
  }
  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}


## -------------------------------------
## EXTENERAL SECRET CONTROLLER 
## ------------------------------------
resource "helm_release" "external-secrets-controller" {
  count        = var.enabled ? 1 : 0
  depends_on   = [local_file.kubeconfig.0]
  name         = "external-secret"
  repository   = "https://external-secrets.github.io/kubernetes-external-secrets"
  chart        = "kubernetes-external-secrets"
  namespace    = "kube-system"
  reuse_values = true
}


## -------------------------------------
## EXTENERAL DNS CONTROLLER 
## ------------------------------------
resource "helm_release" "external-dns-controller" {
  depends_on   = [local_file.kubeconfig.0]
  count        = var.enabled && var.enabled_external_dns ? 1 : 0
  name         = "external-dns"
  repository   = "https://charts.bitnami.com/bitnami"
  chart        = "external-dns"
  namespace    = "kube-system"
  reuse_values = true
  set {
    name  = "provider"
    value = "aws"
  }
  set {
    name  = "aws.zoneType"
    value = var.zoneType
  }
  set {
    name  = "txtOwnerId"
    value = var.hosted_zone_identifier
  }
  set {
    name  = "domainFilters[0]"
    value = var.hosted_zone_name
  }
}


## -------------------------------------
## AWS Cloudwatch
## ------------------------------------
data "template_file" "cloudwatch" {
  count    = var.enable_cloudwatch_container_insights ? 1 : 0
  template = file("${path.module}/templates/cloudwatch.yaml.tpl")
  vars = {
    cluster_name = var.cluster_name
    aws_region   = var.aws_region
  }
}
resource "local_file" "cloudwatch" {
  count    = var.enabled ? 1 : 0
  content  = data.template_file.cloudwatch[0].rendered
  filename = pathexpand("${var.kube_folder_path}/cloudwatch_${var.cluster_name}.yaml")
}
resource "null_resource" "cloudwatch" {
  count      = var.enabled ? 1 : 0
  depends_on = [helm_release.fluentbit]
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.kube_folder_path}/cloudwatch_${var.cluster_name}.yaml --kubeconfig ${local_file.kubeconfig.0.filename}"
  }
  triggers = {
    content = var.enabled ? local_file.cloudwatch.0.content : ""
  }
}



## -------------------------------------
## AWS EKS FluentBit
## ------------------------------------
data "template_file" "fluent-bit" {
  count    = var.enabled && var.enable_fluent_bit ? 1 : 0
  template = file("${path.module}/templates/fluentbit.yaml.tpl")
  vars = {
    cluster_name = var.cluster_name
    region       = var.aws_region
  }
}
resource "helm_release" "fluentbit" {
  depends_on = [local_file.kubeconfig.0]
  # custom helm chart to match https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-logs-FluentBit.html config
  count            = var.enabled && var.enable_fluent_bit ? 1 : 0
  name             = "fluent-bit"
  chart            = "${path.module}/charts/aws-for-fluent-bit" # Chart name at Chart.yaml was updated to 'fluent-bit' to match the expected prometheus dashboard config
  create_namespace = true
  namespace        = "amazon-cloudwatch"
  force_update     = true
  recreate_pods    = true
  values = [
    data.template_file.fluent-bit[0].rendered
  ]
}


# -------------------------------------
# AWS Prometheus
# ------------------------------------
resource "null_resource" "prometheus-cwagent" {
  count      = var.enabled && var.enable_prometheus_dashboard && var.enable_fluent_bit ? 1 : 0
  depends_on = [helm_release.fluentbit]
  provisioner "local-exec" {
    # Based on https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/service/cwagent-prometheus/prometheus-eks.yaml
    command = "kubectl apply -f ${path.module}/yaml/prometheus-eks.yaml --kubeconfig ${local_file.kubeconfig.0.filename}"
  }
  triggers = {
    content = file("${path.module}/yaml/prometheus-eks.yaml")
  }
}
resource "null_resource" "prometheus-dashboard" {
  count      = var.enabled && var.enable_prometheus_dashboard && var.enable_fluent_bit ? 1 : 0
  depends_on = [null_resource.prometheus-cwagent]
  provisioner "local-exec" {
    command = "curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/service/cwagent-prometheus/sample_cloudwatch_dashboards/fluent-bit/cw_dashboard_fluent_bit.json | sed 's/{{YOUR_AWS_REGION}}/${var.aws_region}/g' | sed 's/{{YOUR_CLUSTER_NAME}}/${var.cluster_name}/g' | xargs -0 aws cloudwatch put-dashboard --dashboard-name prometheus_${var.cluster_name} --dashboard-body"
  }
  triggers = {
    content = file("${path.module}/yaml/prometheus-eks.yaml")
  }
}