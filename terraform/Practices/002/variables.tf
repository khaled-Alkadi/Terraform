variable "vnet_names" {
  type = list(string)
  default = [ "backend", "frontend" ]
}
variable "vnet_cidr_blocks" {
  type = list(string)
  default = [ "10.1.0.0/16", "10.2.0.0/16" ]
}