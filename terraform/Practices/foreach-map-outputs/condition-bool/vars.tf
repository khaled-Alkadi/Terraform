variable "st_names" {
  type = map(object({
    account_rep_type = string
    account_kind     = string
    account_tier     = string
    access_tier      = string
  }))
  default = {
    "st01" = {
      account_rep_type = "LRS",
      account_kind     = "StorageV2",
      account_tier     = "Standard",
      access_tier      = "Hot"
    },
    "st02" = {
      account_rep_type = "LRS",
      account_kind     = "StorageV2",
      account_tier     = "Standard",
      access_tier      = "Hot"
    }
  }
}
variable "enable_st_creation" {
  type = bool
  default = true
}