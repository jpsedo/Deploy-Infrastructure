#===================#
#   Health Checks   #
#===================#

## Health Check Heredia-Fibra ##
resource "aws_route53_health_check" "hc_heredia_fibra" {
  ip_address        = "201.207.102.249"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 10
  enable_sni        = true
  disabled          = false
  tags = {
    Name = "Heredia-Fibra"
  }
}


## Health Check Golfito-Cabletica ##
resource "aws_route53_health_check" "hc_golfito_ct" {
  ip_address        = "186.15.126.143"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = 2
  request_interval  = 30
  enable_sni        = false
  disabled          = false
  tags = {
    Name = "Golfito-Liberty"
  }
}


## Health Check Golfito-Fibra ##
resource "aws_route53_health_check" "hc_golfito_fibra" {
  ip_address        = "190.113.84.3"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/"
  failure_threshold = 2
  request_interval  = 30
  enable_sni        = true
  disabled          = false
  tags = {
    Name = "Golfito-Fibra"
  }
}


# Health Check Heredia-Liberty ##
resource "aws_route53_health_check" "hc_heredia_liberty" {
  ip_address        = "186.64.189.45"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 10
  enable_sni        = true
  disabled          = false
  tags = {
    Name = "Heredia-Liberty"
  }
}

