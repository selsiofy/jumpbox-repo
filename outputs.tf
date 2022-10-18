output id {
  value      = azurerm_resource_group.bastion.id
  description = "Resource group ID"
}
output "public_ip_id" {
  value       = azurerm_public_ip.bastion_ip.id
  description = "public IP  ID "
}
