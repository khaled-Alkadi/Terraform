variable "ky_configs" {
  type = object({
    name = string
    rg_name = string
    loc = string
    sku = string
    ten_id = string
    rbac = bool
    pub_access = bool
    soft_delete = number
  })
}