provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "kanban_app" {
  zone_id = var.cloudflare_zone_id
  name    = "kanban"
  value   = var.lb_ip_address
  type    = "A"
  ttl     = 300
  proxied = false
}
