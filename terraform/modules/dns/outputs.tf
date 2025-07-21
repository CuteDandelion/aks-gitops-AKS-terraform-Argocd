output "dns_record_name" {
  value = cloudflare_record.kanban_app.hostname
}
