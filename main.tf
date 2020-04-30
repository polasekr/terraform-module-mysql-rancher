resource "azurerm_mysql_server" "mysql" {
  name                = "${var.db_name}-mysqlsvr"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = var.storage_mb
    backup_retention_days = var.backup_retention_days
    geo_redundant_backup  = var.geo_redundant_backup
  }

  administrator_login          = var.admin_username
  administrator_login_password = var.password
  version                      = var.db_version
  ssl_enforcement              = var.ssl_enforcement
}

resource "azurerm_mysql_database" "mysql" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  charset             = var.charset
  collation           = var.collation
}

resource "azurerm_mysql_firewall_rule" "mysql" {
  name                = "${var.db_name}-fwrules"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address
}
