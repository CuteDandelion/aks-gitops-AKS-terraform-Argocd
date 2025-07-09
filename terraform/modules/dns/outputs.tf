output "dns_zone_id" {
  value       = azurerm_dns_zone.dns.id
  description = "ID of the Azure DNS zone"
}

output "dns_zone_name_servers" {
  value       = azurerm_dns_zone.dns.name_servers
  description = "Name servers for the Azure DNS zone"
}
