Table of Contents
- [Consumption](#consumption)
  - [From Git repo](#from-git-repo)
  - [Locally](#locally)
- [Module details](#module-details)


<!-- ================================================================================================ -->
<!-- README TEMPLATE FOOTER -->
---
<br><br>
# Consumption
> Modules versions are based in: https://www.terraform.io/docs/extend/best-practices/versioning.html

## From Git repo
Define module source pointing to the Git hub url repo as follow:
```bash
source = "github.com/<organization>/<repository>.git?ref=<branch or Tag>" 
```
To force clients to download always the latest code from the specified branch/tag run init as follow [more info at https://www.terraform.io/docs/cli/commands/init.html#child-module-installation]
```bash
terraform init -upgrade
```

## Locally
Clone the git repo and reference the path at your main.tf as follow
```bash
source = "source = "./modules/<folder_name>" 
```

<br><br>

---
<br><br>
# Module details

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.54.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.2.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.eks-node-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_instance_profile.iam_workers_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.autoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_iam_policy_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_iam_policy_cognito](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_iam_policy_external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_iam_policy_loadbalancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_iam_policy_secrets_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.k8s_masters_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.k8s_workers_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSServicePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.CloudWatchAgentServerPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_autoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_cognito_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_external_dns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_ingress_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_secrets_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.k8s_masters_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.k8s_workers_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.app_inbound_traffic_workers_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.masters_inbound_traffic_workers_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.outbound_traffic_masters_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.outbound_traffic_workers_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_inbound_443_traffic_masters_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.self_traffic_workers_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.workers_inbound_443_traffic_masters_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [helm_release.aws-load-balancer-controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external-dns-controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external-secrets-controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.fluentbit](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [local_file.cloudwatch](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.config_map_aws_auth](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.ro_cluster_role](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.ro_role_binding](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.TargetGroupBinding](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.cloudwatch](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.deploy_aws_auth_cm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.deploy_ro_cluster_role](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.deploy_ro_role_binding](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.prometheus-cwagent](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.prometheus-dashboard](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.tiller_service_account](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.tiller_service_account_role](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_iam_policy_document.autoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [template_file.aws_auth_config_map](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.cloudwatch](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.fluent-bit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.map_users](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_app_ports"></a> [allow\_app\_ports](#input\_allow\_app\_ports) | A list of TCP ports to open in the K8S workers SG for instances/services in the VPC | `list` | <pre>[<br>  "22",<br>  "80",<br>  "443"<br>]</pre> | no |
| <a name="input_allowed_ips_k8s_api_access"></a> [allowed\_ips\_k8s\_api\_access](#input\_allowed\_ips\_k8s\_api\_access) | A list of public IPs allowed to access the K8S API | `list` | `[]` | no |
| <a name="input_asg_desired_size"></a> [asg\_desired\_size](#input\_asg\_desired\_size) | The number of instances that should be running in the ASG | `any` | n/a | yes |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | The maximum size of the autoscaling group for K8S workers | `any` | n/a | yes |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | The minimum size of the autoscaling group for K8S workers | `any` | n/a | yes |
| <a name="input_aws_ami"></a> [aws\_ami](#input\_aws\_ami) | aws ami | `string` | `"ami-0c28139856aaf9c3b"` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | aws region used at templates | `string` | `"us-east-1"` | no |
| <a name="input_boot_volume_size"></a> [boot\_volume\_size](#input\_boot\_volume\_size) | The size of the root volume in GBs | `any` | n/a | yes |
| <a name="input_boot_volume_type"></a> [boot\_volume\_type](#input\_boot\_volume\_type) | The type of volume to allocate [gp2\|io1] | `string` | `"gp2"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `any` | n/a | yes |
| <a name="input_enable_cloudwatch_container_insights"></a> [enable\_cloudwatch\_container\_insights](#input\_enable\_cloudwatch\_container\_insights) | Enable Cloudwatch container insights | `bool` | `true` | no |
| <a name="input_enable_fluent_bit"></a> [enable\_fluent\_bit](#input\_enable\_fluent\_bit) | Enable fluent bit logging | `bool` | `true` | no |
| <a name="input_enable_prometheus_dashboard"></a> [enable\_prometheus\_dashboard](#input\_enable\_prometheus\_dashboard) | Deploy cwagent-prometheus and creates a dashboard | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Specify if resource should be created or not. Since it uses the helm provider internally, the whole module cannot be conditionally deployed | `bool` | `true` | no |
| <a name="input_enabled_external_dns"></a> [enabled\_external\_dns](#input\_enabled\_external\_dns) | Enable external DNS | `bool` | `false` | no |
| <a name="input_hosted_zone_identifier"></a> [hosted\_zone\_identifier](#input\_hosted\_zone\_identifier) | n/a | `string` | `""` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | n/a | `string` | `""` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of provisioned IOPS if volume type is io1 | `number` | `0` | no |
| <a name="input_keypair_name"></a> [keypair\_name](#input\_keypair\_name) | The name of an existing key pair to access the K8S workers via SSH | `string` | `""` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the KMS key to use for encryption | `string` | `""` | no |
| <a name="input_kube_folder_path"></a> [kube\_folder\_path](#input\_kube\_folder\_path) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_lb_target_group"></a> [lb\_target\_group](#input\_lb\_target\_group) | The App LB target group ARN we want this AutoScaling Group belongs to | `string` | `""` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | A list of maps with the IAM users allowed to access EKS | `list` | `[]` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | Node group name for K8S workers | `any` | n/a | yes |
| <a name="input_private_subnets_ids"></a> [private\_subnets\_ids](#input\_private\_subnets\_ids) | The IDs of at least two private subnets to deploy the K8S workers in | `list(string)` | n/a | yes |
| <a name="input_public_subnets_ids"></a> [public\_subnets\_ids](#input\_public\_subnets\_ids) | The IDs of at least two public subnets for the K8S control plane ENIs | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Extra set of tags to add to all child resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR range used in the VPC | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where we are deploying the EKS cluster | `any` | n/a | yes |
| <a name="input_workers_instance_type"></a> [workers\_instance\_type](#input\_workers\_instance\_type) | The instance type for the K8S workers | `any` | n/a | yes |
| <a name="input_workers_os"></a> [workers\_os](#input\_workers\_os) | The Linux OS we want for the K8S workers [ubuntu\|amazon] | `string` | `"amazon"` | no |
| <a name="input_zoneType"></a> [zoneType](#input\_zoneType) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca"></a> [cluster\_ca](#output\_cluster\_ca) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_kubeconfig-certificate-authority-data"></a> [kubeconfig-certificate-authority-data](#output\_kubeconfig-certificate-authority-data) | n/a |
| <a name="output_workers_security_group_id"></a> [workers\_security\_group\_id](#output\_workers\_security\_group\_id) | n/a |

<!--- END_TF_DOCS --->