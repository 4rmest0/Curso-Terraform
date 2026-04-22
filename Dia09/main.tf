resource "azurerm_resource_group" "example" {

  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    # ignore_changes = [ tags ]
    precondition {
      condition = contains(var.allowed_locations, var.location)
      error_message = "Porfavor introduce una localizacion valida"
    }
  }

  name     = "${var.environment}-resources-v2"
  location = var.location
  tags = { 
  environment = var.environment
  }


}

resource "azurerm_storage_account" "example" {

  #count = lenght(var.storage_account_name)
  for_each                 = var.storage_account_name
  #name = var.storage_account_name(count.index)
  name                     = each.value
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.environment
  }

    lifecycle {
    create_before_destroy = true
    ignore_changes = [ account_replication_type ]
    replace_triggered_by = [ azurerm_resource_group.example.id ]
  }
} 