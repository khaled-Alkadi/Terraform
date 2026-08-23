variable "comm_location" {
  type = string
  default = "swedencentral"
}
variable "rg_name" {
  type = string
  description = "name of the resource group"
}
variable "vnet_name" {
  type = string
}
variable "add_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
}
