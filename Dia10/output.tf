output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "demo" {
  value = [for count in local.nsg_rules : count.description]
}

output "splat" {
  value = var.account_names[*]
}