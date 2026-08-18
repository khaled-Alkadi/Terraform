variable "resource_group" {
  type        = string
  description = "resource Group name"
  default     = "rg-dynamic-vars"
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
variable "subnets_map" {
  type        = map(string)
  description = "dynamic subnets"
  default = {
    "sub-internal" = "10.0.1.0/24"
    "sub-public"   = "10.0.2.0/24"
    "sub-database" = "10.0.3.0/24"
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
variable "nsg_rules" {
  type = map(object({
    port     = string
    priority = number
  }))
  description = "Dynamic Rules"
  default = {
    "Allow-HTTP" = { priority = 100, port = "80" },
    "Allow-SHH"  = { priority = 110, port = "22" }
  }
}