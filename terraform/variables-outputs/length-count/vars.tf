variable "location" {
  type = string
  description = "Location of Service"
  default = "northeurope"
}
variable "service_names" {
  type = list(string)
  description = "List of Services"
  default = [ "network", "app", "database" ]
}
