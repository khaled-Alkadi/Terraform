variable "vnet_address" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subs_names" {
  type = map(object({
    cidr = string
  }))
  default = {
    "frontend" = { cidr = "10.0.1.0/24" }
    "backend"  = { cidr = "10.0.2.0/24" }
  }
}