variable "sts_config" {
  type = map(object({
    hns = optional(bool, false)
    repl_type = string
    acc_tier = string
  }))
  default = {
    "stdevlogs01" = {acc_tier = "Standard", repl_type = "LRS"}
    "stproddata01" = {hns = true, acc_tier = "Premium", repl_type = "ZRS"}
  }
}