terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0f4cf4474622ba9dd"
  instance_type = "t2.micro"
}


# resource "aws_lightsail_static_ip" "Master_Autozona_IP" {
#   name = "Master_Autozona_IP"
# }


# ## Creacion de IP estatica para agregar a la instancia de docker
# resource "aws_lightsail_static_ip_attachment" "Attachment_AutozonaIP" {
#   static_ip_name = aws_lightsail_static_ip.Master_Autozona_IP.id
#   instance_name  = aws_lightsail_instance.Autozona-Master.id
# }

# # Creacion del master node  para docker de autozona
# resource "aws_lightsail_instance" "Autozona-Master" {
#   name              = "Autozona-Master"
#   availability_zone = "us-east-1a"
#   blueprint_id      = "ubuntu_18_04"
#   bundle_id         = "micro_2_0"
#   key_pair_name     = "Autozona"
#   tags = {
#     Autozona = "Docker"
#   }
# }


# resource "aws_lightsail_instance" "Autozona-Worker01" {
#   name              = "Autozona-Worker01"
#   availability_zone = "us-east-1a"
#   blueprint_id      = "ubuntu_18_04"
#   bundle_id         = "micro_2_0"
#   key_pair_name     = "Autozona"
#   tags = {
#     Autozona = "Docker"
#   }
# }


# #creacion del record SIMPLE de DNS
# #https://registry.terraform.io/modules/clouddrove/route53-record/aws/latest
#   module "route53-record" {
#     source  = "clouddrove/route53-record/aws"
#     version = "0.15.0"
#     zone_id = "Z09078103J31CYFV896RW"
#     name    = "master"
#     type    = "A"
#     ttl     = "60"
#     values  = "54.80.53.96" ##se debe cambiar este valor, con la ip de la tarjeta creada arriba.
#   }

