variable "env_names" {
  type        = list(string)
  description = "Availble environments"
  default     = ["dev", "stage", "prod"]
}
variable "enable_creation" {
  type    = bool
  default = true
}