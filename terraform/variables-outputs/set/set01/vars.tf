variable "rg_names" {
  type    = set(string)
  default = ["rg-dev", "rg-web", "rg-prod"]
}