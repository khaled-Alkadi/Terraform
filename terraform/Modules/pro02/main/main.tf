module "dev_rg" {
  source  = "../modules/rg_module"
  rg_name = "rg-dev"
}
module "prod_rg" {
  source        = "../modules/rg_module"
  rg_name       = "rg-prod"
  comm_location = "northeurope"
}
# vnets:
########
module "dev_vnet" {
  source    = "../modules/vnet_module"
  rg_name   = module.dev_rg.rg_name_out
  vnet_name = "vnet-dev"
}
module "prod_vnet" {
  source        = "../modules/vnet_module"
  comm_location = "northeurope"
  rg_name       = module.prod_rg.rg_name_out
  vnet_name     = "vnet-prod"
  add_space = ["10.1.0.0/16"]
}