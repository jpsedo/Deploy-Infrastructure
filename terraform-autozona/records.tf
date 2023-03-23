#===================#
# Route53 - Records #
#===================#

# Records for Electrozona ##


resource "aws_route53_record" "ez_remot_a1" {
  name = "remoto.electrozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.electrozona.id
  records        = ["186.15.126.143"]
  set_identifier = "ez_rem_1"
  health_check_id = resource.aws_route53_health_check.hc_golfito_ct.id
}

resource "aws_route53_record" "ez_remot_a2" {
  name = "remoto.electrozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.electrozona.id
  records        = ["190.113.84.3"]
  set_identifier = "ez_rem_2"
  health_check_id = resource.aws_route53_health_check.hc_golfito_fibra.id
}

resource "aws_route53_record" "ez_routr_a1" {
  name = "router.electrozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.electrozona.id
  records        = ["186.15.126.143"]
  set_identifier = "ez_rtr_1"
  health_check_id = resource.aws_route53_health_check.hc_golfito_ct.id
}

resource "aws_route53_record" "ez_routr_a2" {
  name = "router.electrozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.electrozona.id
  records        = ["190.113.84.3"]
  set_identifier = "ez_rtr_2"
  health_check_id = resource.aws_route53_health_check.hc_golfito_fibra.id
}

resource "aws_route53_record" "ez_zbx_a1" {
  name = "zabbix.electrozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.electrozona.id
  records        = ["186.15.126.143"]
  set_identifier = "ez_zbx_1"
  health_check_id = resource.aws_route53_health_check.hc_golfito_ct.id
}

resource "aws_route53_record" "ez_zbx_a2" {
  name = "zabbix.electrozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.electrozona.id
  records        = ["190.113.84.3"]
  set_identifier = "ez_zbx_2"
  health_check_id = resource.aws_route53_health_check.hc_golfito_fibra.id
}


## Records for Autozona ##


resource "aws_route53_record" "az_txt" {
  name    = "autozona.click"
  type    = "TXT"
  ttl     = 3600
  zone_id = aws_route53_zone.autozona.id
  records = ["ds13xb8mlq79nn6jkhw09k097c786x09"]
}

resource "aws_route53_record" "az_cname" {
  name    = "_45ae1731aca467eb188ba5a47285bae0.autozona.click"
  type    = "CNAME"
  ttl     = 60
  zone_id = aws_route53_zone.autozona.id
  records = ["DC239393037800451EA3EE712516F488.BA70E1DC3700AE3F739E8E3021698ED9.6235190e2a805.comodoca.com"]
}

resource "aws_route53_record" "az_a1" {
  name = "camaras1.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}

resource "aws_route53_record" "az_cam_a2" {
  name = "camaras2.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_cam_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_cam_a1" {
  name = "camaras2.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_cam_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}

resource "aws_route53_record" "az_graf_a2" {
  name = "grafana.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_graf_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_graf_a1" {
  name = "grafana.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_graf_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}

resource "aws_route53_record" "az_inv_a2" {
  name = "inventario.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_inv_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_inv_a1" {
  name = "inventario.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_inv_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}

resource "aws_route53_record" "az_jen_a2" {
  name = "jenkins.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_jen_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_jen_a1" {
  name = "jenkins.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_jen_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}


resource "aws_route53_record" "az_nx_a2" {
  name = "nextcloud.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_nx_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_nx_a1" {
  name = "nextcloud.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_nx_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}


resource "aws_route53_record" "az_rout_a" {
  name    = "router.autozona.click"
  type    = "A"
  ttl     = 60
  zone_id = aws_route53_zone.autozona.id
  records = ["192.168.1.1"]
}

resource "aws_route53_record" "az_unif_a" {
  name    = "unifi.autozona.click"
  type    = "A"
  ttl     = 60
  zone_id = aws_route53_zone.autozona.id
  records = ["192.168.1.117"]
}

resource "aws_route53_record" "az_vent_a2" {
  name = "ventas.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_vent_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_vent_a1" {
  name = "ventas.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_vent_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}

resource "aws_route53_record" "az_vpn_a2" {
  name = "vpn.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_vpn_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_vpn_a1" {
  name = "vpn.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_vpn_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}


resource "aws_route53_record" "az_zbx_a2" {
  name = "zabbix.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "SECONDARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["186.64.189.45"]
  set_identifier = "az_zbx_a2"
  health_check_id = resource.aws_route53_health_check.hc_heredia_liberty.id
}

resource "aws_route53_record" "az_zbx_a1" {
  name = "zabbix.autozona.click"
  type = "A"
  ttl  = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  zone_id        = aws_route53_zone.autozona.id
  records        = ["201.207.102.249"]
  set_identifier = "az_zbx_a1"
  health_check_id = resource.aws_route53_health_check.hc_heredia_fibra.id
}