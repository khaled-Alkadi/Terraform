variable "sub_config" {
  type = object({
    sub_name  = string
    vnet_name = string
    rg_name   = string
    prefix    = string
  })
}