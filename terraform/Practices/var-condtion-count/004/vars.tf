variable "nsg_names" {
  type = list(string)
  default = [ "web", "app", "db" ]
}
variable "enable_nsg_creation" {
  type = bool
  default = true
}