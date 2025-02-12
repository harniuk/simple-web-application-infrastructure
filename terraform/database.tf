resource "azurerm_mysql_flexible_server" "db" {
  name                   = "dbserver-simple-wai"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = var.location
  administrator_login    = var.db_username
  administrator_password = var.db_password
  sku_name               = "B_Standard_B1ms"
  zone                   = "3"
}