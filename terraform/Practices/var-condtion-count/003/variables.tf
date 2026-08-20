variable "sub_names" {
  type    = list(string)
  default = ["web", "db"]
}
variable "sub_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "enable_subs" {
  type    = bool
  default = true
}