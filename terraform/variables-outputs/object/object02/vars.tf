variable "sub_config" {
  type = object({
    name              = string
    prefix            = string
    service_endpoints = optional(list(string), [])
  })
  default = {
    name              = "sub1"
    prefix            = "10.0.1.0/24"
    service_endpoints = ["Microsoft.Storage"]
  }
}