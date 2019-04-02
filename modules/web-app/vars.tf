variable "resource_group_name" {}
variable "environment" {}
variable "department" {}
variable "function_name" {}
variable "service_plan_name" {}
variable "app_service_name" {}
variable "https_only" {}

variable "enable_staging" {}
variable "enable_blue_green" {}
variable "app_service_settings" {
    type = "map"
}