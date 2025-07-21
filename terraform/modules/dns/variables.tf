variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API Token with DNS edit permissions"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The Cloudflare Zone ID for hanadisa.com"
}

variable "lb_ip_address" {
  type        = string
  description = "Public IP address of the NGINX ingress controller"
}
