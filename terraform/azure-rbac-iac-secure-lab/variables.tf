variable "validate_environments" {
  description = "Prefix for infrastructure component environments"
  type        = map(string)
  default = {
    compute  = "comp"
    database = "db"
  }
  validation {
    condition = alltrue([
      for v in values(var.validate_environments) : contains(["comp", "db"], v)
    ])
    error_message = "Environment values must only contain 'comp' or 'db'."
  }
}
variable "location" {
  type        = string
  description = "Azure Region"
  default     = "westeurope"
}
