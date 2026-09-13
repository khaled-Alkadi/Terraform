variable "nic_config" {
  type = object({
    nic_name = string
    rg_name   = string
    target_subnet_id  = string
    loc    = string
  })
}