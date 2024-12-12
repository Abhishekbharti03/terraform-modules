resource "azurerm_cosmosdb_account" "db" {
    lifecycle {
      prevent_destroy = true
    }

    name                    = var.cosmosdb_name
    location                = var.cosmosdb_location
    resource_group_name     = var.cosmosdb_resource_group_name
    offer_type              = "Standard"

    enable_automatic_failover           = false
    public_network_access_enabled       = true
    is_virtual_network_filter_enabled   = true
    local_authentication_disabled       = true

    capabilities {
      name = "EnableServerless"
    }

    consistency_policy {
      consistency_level         = "BoundedStaleness"
      max_interval_in_seconds   = 300
      max_staleness_prefix      = 100000
    }   

    geo_location {
      location = var.cosmosdb_geo_location1
      failover_priority = 0
    }

    dynamic "virtual_network_rule" {
        for_each = var.cosmosdb_vnet_subnet_ids

        content {
          id = virtual_network_rule.value
        }
      
    }
    tags = var.cosmosdb_tags  
}

resource "azurerm_cosmosdb_sql_database" "db" {
    count                      = var.cosmosdb_database_name == null ? 0 : 1  ## We are using count to pass the boolean whether create the db or not ####
    name                       = var.cosmosdb_database_name
    resource_group_name        = var.cosmosdb_resource_group_name
    account_name               = var.cosmosdb_name
    depends_on                 = [ azurerm_cosmosdb_account.db ]
  
}


resource "azurerm_cosmosdb_sql_container" "container" {
    count                      = var.cosmosdb_container_name == null ? 0 : 1
    name                       = var.cosmosdb_container_name
    resource_group_name        = var.cosmosdb_resource_group_name
    account_name               = var.cosmosdb_name
    database_name              = var.cosmosdb_database_name
    partition_key_paths        = var.cosmosdb_container_partition_key_path

    depends_on                 = [ azurerm_cosmosdb_sql_database.db ]
  
}