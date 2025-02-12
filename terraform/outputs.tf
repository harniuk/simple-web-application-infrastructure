output "vm_public_ip" {
  description = "Public IP of the Virtual Machine"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "db_fqdn" {
  description = "Fully Qualified Domain Name of the MySQL Database"
  value       = azurerm_mysql_flexible_server.db.fqdn
}
