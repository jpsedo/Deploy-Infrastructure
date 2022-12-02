Table of Contents
- [Terraform module for AWS EKS service](#terraform-module-for-aws-eks-service)
    - [Fluent Bit and Prometheus dashboard](#fluent-bit-and-prometheus-dashboard)
  - [Example](#example)

<br><br>

---
<br><br>

# Terraform module for AWS EKS service

Terraform module which creates an AWS EKS Kubernetes cluster in a given VPC.

At the moment it only supports Amazon Linux2 image optimized for EKS K8S workers
but the support of Ubuntu 18.04 for EKS workers is planned as a future improvement.

The module supports encryption at rest. In that case the official AMI is copied
and encrypted so workers are launched from the encrypted image making the EBS
boot volume encrypted by default at launch time. 

When the cluster is created, the config map aws-auth is deployed by default,
allowing the workers to join the masters automatically. Also, a service account 
for Tiller (server-side of Helm) is created with cluster-admin permissions, 
so you can deploy Charts on top of this cluster. 

>Note: Since the Terraform provider for K8S does not support the credentials 
plugin exec feature yet, we create kube objects using a null resource for now.

Lastly, some additional IAM policies are created and attached to the worker nodes
so features like cluster autoscaler or external-DNS can be implemented without
additional work from the IAM side. 


### Fluent Bit and Prometheus dashboard
> **NOTE:**
> * Ensure that worker nodes have the `CloudWatchAgentServerPolicy` policie assigned
> * To remove FluentD previous config run [below commands](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContainerInsights-delete-agent.html):
> ```bash
> curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/$ClusterName/;s/{{region_name}}/$RegionName/" | kubectl delete -f -
> ```
> * To remove prometheus completly run below command:
> ```bash
> cat ./yaml/prometheus-eks.yaml | kubectl delete -f -
> ```


## Example

```bash
module "eks_cluster" {
  source = "github.com/truenorth-tech/tf_aws_eks_cluster.git?ref=<branch or Tag>"
  # Network settings
  vpc_id              = "${module.vpc.vpc_id}"
  vpc_cidr            = "${module.vpc.vpc_cidr}"
  public_subnets_ids  = [["${module.vpc.public_subnets_ids}"]]
  private_subnets_ids = [["${module.vpc.private_subnets_ids}"]]

  # EKS settings
  cluster_name          = "${terraform.workspace}-eks-cluster"
  keypair_name          = "${terraform.workspace}-ssh-key"
  workers_instance_type = "t2.medium"  
  boot_volume_size      = 100
  encrypted_boot_volume = true
  asg_min_size          = 2
  asg_desired_size      = 4
  asg_max_size          = 8

  # Additional tags to be added to the AutoScaling Group (workers)
  tags = [ tolist(
    tomap({"key"= "App", "value"= "Web", "propagate_at_launch"= true}),
     tomap({"key"= "Environment", "value"= terraform.workspace, "propagate_at_launch"= true})
    )
  ]
}
```


> **NOTE:**
> 
> Module cannot be conditionally deployed due internally it calls a provider (helm) that cannot be moved outside this module as it references the kubeconfig file of the created cluster