variable "resource_group_name" {}
variable "key_vault_name" {}
variable "tenant_id" {}
variable "service_principal_name" {}
variable "certificate_permissions" {
    type = "list"
}
variable "key_permissions" {
    type = "list"
}
variable "secret_permissions" {
    type = "list"
}