variable "rg_name" {
  type = string
  default = "test-rg"
}
# to change var-value: 
# powershell: $env:TF_VAR_rg_name="..."