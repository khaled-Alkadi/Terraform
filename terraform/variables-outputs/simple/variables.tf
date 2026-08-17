variable "resource_group" {
  type        = string
  description = "resource Group name"
  default     = "rg-challenge-dev"
}
variable "location" {
  type        = string
  description = "location of resources"
  default     = "northeurope"
}
variable "virtual_network" {
  type        = string
  description = "virtual network name"
  default     = "vnet-challenge"
}
variable "subnets_names" {
  type        = map(string)
  description = "set of subnets"
  default = {
    "intern" = "10.0.1.0"
    extern   = "10.0.2.0"
  }
}
variable "common_tags" {
  type        = map(string)
  description = "Tags of resources"
  default = {
    "CreatedBy" = "kha"
    "ManagedBy" = "IaC"
  }
}