variable "sub_config" {
  type = object({
    name     = string
    add_pref = string
  })
  default = {
    name     = "dev-sub"
    add_pref = "10.0.1.0/24"
  }
}