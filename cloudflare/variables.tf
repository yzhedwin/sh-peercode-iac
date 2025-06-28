variable "cloudflare_api_token" {}
variable "cloudflare_account_id" {}
variable "cloudflare_zone_id" {}
variable "cloudflare_tunnel_name_peercode" {
  description = "Name of the Cloudflare Tunnel"
  type        = string
}
variable "cloudflare_tunnel_name_ssh" {
  description = "Name of the Cloudflare SSH Tunnel"
  type        = string
}

variable "cloudflare_services_peercode" {
  description = "Values for the services to be exposed via Cloudflare Tunnel"
  type = map(object({
    hostname = string # public domain name. ex: "service.example.com"
    service  = string # private service endpoint. ex: service.apps.internaldomain.com
  }))
}

variable "cloudflare_services_ssh" {
  description = "Values for the services to be exposed via Cloudflare Tunnel"
  type = map(object({
    hostname = string # public domain name. ex: "service.example.com"
    service  = string # private service endpoint. ex: service.apps.internaldomain.com
  }))
}
