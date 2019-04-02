variable "resource_group_name" {}
variable "environment" {}
variable "department" {}
variable "virtual_network_name" {}
variable "security_group_name" {}
variable "is_os_windows" {}
variable "inbound_traffic_approved_ips" {
    type = "list"
}