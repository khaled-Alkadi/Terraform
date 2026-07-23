variable "environment" {
  type    = string
  default = "dev"
  # condition to accept only dev and prod environments:
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The environment variable must be either 'dev' or 'prod'."
  }
}
variable "db_sku" {
  type = map(string)
  default = {
    "dev"  = "B_Standard_B1ms"    # Correct Burstable tier for dev
    "prod" = "GP_Standard_D2s_v3" # Correct General Purpose tier for prod
  }
}
variable "db_storage_gb" {
  type = map(number)
  default = {
    "dev"  = 32
    "prod" = 1024
  }
}
variable "db_administrator_password" {
  type        = string
  description = "db_pass"
  sensitive   = true
}