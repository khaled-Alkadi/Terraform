variable "nic_names" {
  type = map(object({
    enable_public_ip = bool
    enable_creation = bool
  }))
  default = {
    "nic01" = { enable_creation = true, enable_public_ip = true }
    "nic02" = { enable_creation = true, enable_public_ip = false }
    "nic03" = { enable_creation = false, enable_public_ip = true }
  }
}
variable "enable_nic_creation" {
  type    = bool
  default = true
}