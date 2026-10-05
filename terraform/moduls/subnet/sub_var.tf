variable "sub_configs" {
  type = object({
    name = string
    rg_name = string
    vnet_name = string
    prefix = list(string)
  })
}