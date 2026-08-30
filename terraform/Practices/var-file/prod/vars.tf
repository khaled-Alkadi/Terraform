variable "rgs" {
  type = string
}
variable "location" {
  type = string
  default = "swedencentral"
}
variable "vnet_configs" {
  type = object({
    name = string
    add_space = list(string)
  })
}
variable "sub_configs" {
  type = object({
    name = string
    prefix = list(string)
  })
}
variable "st_configs" {
  type = object({
    name = string
    acc_tier = string
    acc_repl = string
    acc_kind = string
    access_tier = string
  })
}
variable "comm_tags" {
  type = map(string)
}