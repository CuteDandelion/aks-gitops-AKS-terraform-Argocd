provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "kanban_app" {
  count   = var.lb_ip_address != null ? 1 : 0

  zone_id = var.cloudflare_zone_id
  name    = "kanban"
  type    = "A"
  value   = var.lb_ip_address
  ttl     = 300
  proxied = false
  allow_overwrite = true
}
