variable "vnet_configs" {
  type = object({
    name = string
    rg_name = string
    add_space = list(string)
    location = string
  })
}