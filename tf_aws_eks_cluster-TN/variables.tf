## -------------------------------------------------------------
## Network variables
## -------------------------------------------------------------

variable "enabled" {
  description = "Specify if resource should be created or not. Since it uses the helm provider internally, the whole module cannot be conditionally deployed"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The ID of the VPC where we are deploying the EKS cluster"
}

variable "vpc_cidr" {
  description = "The CIDR range used in the VPC"
}

variable "public_subnets_ids" {
  description = "The IDs of at least two public subnets for the K8S control plane ENIs"
  type        = list(string)
}

variable "private_subnets_ids" {
  description = "The IDs of at least two private subnets to deploy the K8S workers in"
  type        = list(string)
}

## -------------------------------------------------------------
## EKS variables
## -------------------------------------------------------------

variable "cluster_name" {
  description = "The name of the EKS cluster"
}

## variable "ec2_ssh_key" {
##   description = "The name of the ec2_ssh_key"  
## }

variable "workers_os" {
  description = "The Linux OS we want for the K8S workers [ubuntu|amazon]"
  default     = "amazon" #### ubuntu image not ready to be used as EKS worker
}


variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption"
  default     = ""
}

variable "workers_instance_type" {
  description = "The instance type for the K8S workers"
}

variable "keypair_name" {
  description = "The name of an existing key pair to access the K8S workers via SSH"
  default     = ""
}

variable "boot_volume_type" {
  description = "The type of volume to allocate [gp2|io1]"
  default     = "gp2"
}

variable "iops" {
  description = "The amount of provisioned IOPS if volume type is io1"
  default     = 0
}

variable "boot_volume_size" {
  description = "The size of the root volume in GBs"
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group for K8S workers"
}

variable "asg_desired_size" {
  description = "The number of instances that should be running in the ASG"
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group for K8S workers"
}
variable "node_group_name" {
  description = "Node group name for K8S workers"
}

variable "lb_target_group" {
  description = "The App LB target group ARN we want this AutoScaling Group belongs to"
  default     = ""
}

variable "map_users" {
  description = "A list of maps with the IAM users allowed to access EKS"
  default     = []

  ## example:
  ##  
  ##  map_users = [
  ##    {
  ##      user_arn = "arn:aws:iam::<aws-account>:user/JohnSmith"
  ##      username = "john"
  ##      group    = "system:masters" ## cluster-admin
  ##    },
  ##    {
  ##      user_arn = "arn:aws:iam::<aws-account>:user/PeterMiller"
  ##      username = "peter"
  ##      group    = "ReadOnlyGroup"  ## custom role granting read-only permissions 
  ##    }
  ##  ]
  ##

}

## -------------------------------------------------------------
## Security variables
## -------------------------------------------------------------

variable "allow_app_ports" {
  description = "A list of TCP ports to open in the K8S workers SG for instances/services in the VPC"
  default     = ["22", "80", "443"]
}
variable "allowed_ips_k8s_api_access" {
  description = "A list of public IPs allowed to access the K8S API"
  default     = []
}

## -------------------------------------------------------------
## Tagging
## -------------------------------------------------------------

variable "tags" {
  description = "Extra set of tags to add to all child resources"
  type        = map(string)
  default     = {}
}

## -------------------------------------------------------------
## AMI
## -------------------------------------------------------------
variable "aws_ami" {
  description = "aws ami"
  default     = "ami-0c28139856aaf9c3b"
}

variable "aws_region" {
  description = "aws region used at templates"
  default     = "us-east-1"
}

variable "aws_profile" {}

variable "kube_folder_path" {
  default = "~/.kube"
}

variable "enable_fluent_bit" {
  description = "Enable fluent bit logging"
  type        = bool
  default     = true
}

variable "enable_prometheus_dashboard" {
  description = "Deploy cwagent-prometheus and creates a dashboard"
  type        = bool
  default     = true
}

variable "enable_cloudwatch_container_insights" {
  description = "Enable Cloudwatch container insights"
  type        = bool
  default     = true
}


## -------------------------------------------------------------
## EXTRENAL DNS VARIABLES
## -------------------------------------------------------------
variable "enabled_external_dns" {
  description = "Enable external DNS"
  default     = false
}
variable "zoneType" {
  default = ""
}
variable "hosted_zone_identifier" {
  default = ""
}
variable "hosted_zone_name" {
  description = ""
  default     = ""
}