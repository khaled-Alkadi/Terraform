variable "en_disable_all_creation" {
  type    = bool
  default = true
}
variable "sub_names" {
  type = map(object({
    en_disable_creation = bool
    address             = string
  }))
  default = {
    "sub01" = { en_disable_creation = true, address = "10.1.0.0/24" }
    "sub02" = { en_disable_creation = false, address = "10.2.0.0/24" }
    "sub03" = { en_disable_creation = true, address = "10.3.0.0/24" }
  }
}