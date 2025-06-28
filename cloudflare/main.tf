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

module "ssh_tunnel" {

  source                 = "./ssh_tunnel"
  cloudflare_account_id  = var.cloudflare_account_id
  cloudflare_api_token   = var.cloudflare_api_token
  cloudflare_zone_id     = var.cloudflare_zone_id
  cloudflare_services    = var.cloudflare_services_ssh
  cloudflare_tunnel_name = var.cloudflare_tunnel_name_ssh

}

module "peercode_tunnel" {

  source                 = "./peercode_tunnel"
  cloudflare_account_id  = var.cloudflare_account_id
  cloudflare_api_token   = var.cloudflare_api_token
  cloudflare_zone_id     = var.cloudflare_zone_id
  cloudflare_services    = var.cloudflare_services_peercode
  cloudflare_tunnel_name = var.cloudflare_tunnel_name_peercode

}
