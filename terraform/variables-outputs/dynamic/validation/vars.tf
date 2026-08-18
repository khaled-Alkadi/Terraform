variable "einvironments" {
  type = string
  description = "allowed einvironments"
  validation {
    condition = contains(["dev", "prod", "stage"], var.einvironments)
    error_message = "The Deployment must have one of this prefixes: (dev, prod, stage)"
  }
}
variable "dynamic_subnets" {
  type = map(object({
    prefix = string
  }))
  description = "subnets names and prefixes"
  default = {
    "sub-internal" = {prefix = "10.0.1.0/24"},
    "sub-public" = {prefix = "10.0.2.0/24"}
  }
}