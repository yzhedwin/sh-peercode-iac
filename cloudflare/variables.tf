variable "cloudflare_api_token" {}
variable "cloudflare_account_id" {}
variable "cloudflare_zone_id" {}
variable "cloudflare_services" {
  description = "Values for the services to be exposed via Cloudflare Tunnel"
  type = map(object({
    hostname = string # public domain name. ex: "service.example.com"
    service  = string # private service endpoint. ex: service.apps.internaldomain.com
  }))
}
