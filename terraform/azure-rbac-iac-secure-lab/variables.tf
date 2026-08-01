variable "environments" {
  type        = map(string)
  description = "exist environments"
  default = {
    "compute"  = "comp"
    "database" = "db"
  }
}