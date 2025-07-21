output "dns_record_name" {
  value = length(cloudflare_record.kanban_app) > 0 ? cloudflare_record.kanban_app[0].hostname : ""
}
