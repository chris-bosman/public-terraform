output "id" {
    value = "${azurerm_storage_account.deployment.id}"
}

output "name" {
    value = "${azurerm_storage_account.deployment.name}"
}

output "primary_location" {
    value = "${azurerm_storage_account.deployment.primary_location}"
}

output "secondary_location" {
    value = "${azurerm_storage_account.deployment.secondary_location}"
}

output "primary_blob_endpoint" {
    value = "${azurerm_storage_account.deployment.primary_blob_endpoint}"
}

output "primary_queue_endpoint" {
    value = "${azurerm_storage_account.deployment.primary_queue_endpoint}"
}

output "primary_table_endpoint" {
    value = "${azurerm_storage_account.deployment.primary_table_endpoint}"
}

output "primary_file_endpoint" {
    value = "${azurerm_storage_account.deployment.primary_file_endpoint}"
}

output "primary_access_key" {
    value = "${azurerm_storage_account.deployment.primary_access_key}"
}

output "secondary_access_key" {
    value = "${azurerm_storage_account.deployment.secondary_access_key}"
}

output "primary_connection_string" {
    value = "${azurerm_storage_account.deployment.primary_connection_string}"
}

output "secondary_connection_string" {
    value = "${azurerm_storage_account.deployment.secondary_connection_string}"
}

output "primary_blob_connection_string" {
    value = "${azurerm_storage_account.deployment.primary_blob_connection_string}"
}