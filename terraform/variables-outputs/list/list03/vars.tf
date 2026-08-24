variable "subnet_names" {
  type    = list(string)
  default = ["web-snet", "app-snet", "db-snet"]
}