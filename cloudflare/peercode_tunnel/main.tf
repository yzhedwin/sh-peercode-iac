terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "random_password" "tunnel_secret" {
  length = 64
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "peercode_tunnel" {
  name          = "peercode-tunnel"
  config_src    = "cloudflare"
  account_id    = var.cloudflare_account_id
  tunnel_secret = base64sha256(random_password.tunnel_secret.result)
}

locals {
  cf_tunnel_secret = jsonencode({
    "AccountTag" : "${var.cloudflare_account_id}",
    "TunnelSecret" : "${base64sha256(random_password.tunnel_secret.result)}",
    "TunnelID" : "${cloudflare_zero_trust_tunnel_cloudflared.peercode_tunnel.id}"
  })
  ingress_rules = [
    for service in var.cloudflare_services : {
      hostname = service.hostname
      origin_request = {
        no_tls_verify = true
      }
      service = service.service
    }
  ]
  cloudflared_config_yaml = yamlencode({
    tunnel           = "peercode-tunnel"
    credentials-file = "/etc/cloudflared/creds/credentials.json"
    metrics          = "0.0.0.0:2000"
    no-autoupdate    = true
    ingress          = concat(local.ingress_rules, [{ service = "http_status:404" }])
  })
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "peercode_tunnel" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.peercode_tunnel.id
  config = {
    ingress = concat(local.ingress_rules, [
      {
        origin_request = {
          connect_timeout        = 0
          keep_alive_connections = 0
          keep_alive_timeout     = 0
          tcp_keep_alive         = 0
          tls_timeout            = 0
        }
        service = "http_status:503"
      },
    ])
    warp_routing = {
      enabled = false
    }
  }

}

resource "kubernetes_secret" "cloudflare_credentials" {
  metadata {
    name      = "tunnel-credentials"
    namespace = "dev"
  }

  data = {
    "credentials.json" = local.cf_tunnel_secret
  }
}

resource "cloudflare_dns_record" "tunnel_app" {
  zone_id = var.cloudflare_zone_id
  name    = "peercode.prosh2.com"
  type    = "CNAME"
  content = join(".", [cloudflare_zero_trust_tunnel_cloudflared.peercode_tunnel.id, "cfargotunnel.com"])
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "tunnel_api_gateway" {
  zone_id = var.cloudflare_zone_id
  name    = "peercode-api.prosh2.com"
  type    = "CNAME"
  content = join(".", [cloudflare_zero_trust_tunnel_cloudflared.peercode_tunnel.id, "cfargotunnel.com"])
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "tunnel_api_match" {
  zone_id = var.cloudflare_zone_id
  name    = "peercode-match.prosh2.com"
  type    = "CNAME"
  content = join(".", [cloudflare_zero_trust_tunnel_cloudflared.peercode_tunnel.id, "cfargotunnel.com"])
  proxied = true
  ttl     = 1
}

resource "kubernetes_deployment" "peercode_tunnel" {
  metadata {
    name      = "cloudflared"
    namespace = "dev"
  }
  spec {
    selector {
      match_labels = {
        app = "cloudflared"
      }
    }
    replicas = 2
    template {
      metadata {
        labels = {
          app = "cloudflared"
        }
      }
      spec {
        container {
          name  = "cloudflared"
          image = "cloudflare/cloudflared:2022.3.0"
          args  = ["tunnel", "--config", "/etc/cloudflared/config/config.yaml", "run"]
          liveness_probe {
            http_get {
              path = "/ready"
              port = 2000
            }
            failure_threshold     = 1
            initial_delay_seconds = 10
            period_seconds        = 10
          }
          volume_mount {
            name       = "config"
            mount_path = "/etc/cloudflared/config"
            read_only  = true
          }
          volume_mount {
            name       = "creds"
            mount_path = "/etc/cloudflared/creds"
            read_only  = true
          }
        }
        volume {
          name = "creds"
          secret {
            secret_name = "tunnel-credentials"
          }
        }
        volume {
          name = "config"
          config_map {
            name = "cloudflared"
            items {
              key  = "config.yaml"
              path = "config.yaml"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map" "cloudflared" {
  metadata {
    name      = "cloudflared"
    namespace = "dev"
  }

  data = {
    "config.yaml" = local.cloudflared_config_yaml
  }
}
