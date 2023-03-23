#===================#
#   Hosted Zones    #
#===================#

## Hosted Zone - Autozona ##
resource "aws_route53_zone" "autozona" {
  name = var.hz_autozona
}
## Hosted Zone - Electrozona ##
resource "aws_route53_zone" "electrozona" {
  name = var.hz_electrozona
}
