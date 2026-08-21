variable "enable_st_creation" {
  type    = bool
  default = true
}
variable "st_names" {
  type = map(object({
    en_st        = bool
    cr_container = bool
  }))
  default = {
    "stdev"  = { en_st = true, cr_container = true }
    "sttest" = { en_st = true, cr_container = false }
    "stpord"  = { en_st = false, cr_container = true }
  }
}