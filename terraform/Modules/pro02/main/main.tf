module "dev_rg" {
  source = "../modules/rg_module"
  rg_name = "rg-dev"
}
module "prod_rg" {
  source = "../modules/rg_module"
  rg_name = "rg-prod"
  comm_location = "northeurope"
}