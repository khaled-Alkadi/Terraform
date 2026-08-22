locals {
  dev_ext = "dev"
  prod_ext = "prod"
}
module "dev_rg" {
  source = "../modules/rgs"
  rg_name = "rg-${local.dev_ext}"
}
module "prod_rg" {
  source = "../modules/rgs"
  rg_name = "rg-${local.prod_ext}"
  default_location = "westeurope"
}