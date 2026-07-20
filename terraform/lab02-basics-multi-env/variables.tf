variable "ssh_public_key_path" {
  type        = string
  description = "The absolute path to the SSH public key on the local machine"
}
variable "env" {
  type        = string
  description = "Target deployment environment (dev, prod)"
  default     = "dev"
}
variable "vm_size_mapping" {
  type        = map(string)
  description = "Map of VM sizes per environment"
  default = {
    "dev"  = "Standard_B1s"
    "prod" = "Standard_D2s_v3"
  }
}