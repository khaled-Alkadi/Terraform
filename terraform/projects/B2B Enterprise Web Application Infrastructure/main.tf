locals {
  env_dev  = "dev"
  env_prod = "prod"
}
module "rg_dev" {
  source = "../../moduls/resource_group"
  rg_configs = {
    name     = "rg-${local.env_dev}"
    location = "France Central"
  }
}
module "vnet_dev" {
  source = "../../moduls/vnet"
  vnet_configs = {
    name      = "vnet-${local.env_dev}"
    rg_name   = module.rg_dev.rg_out.name
    location  = module.rg_dev.rg_out.location
    add_space = ["10.0.0.0/16"]
  }
}
module "sub_frontend_dev" {
  source = "../../moduls/subnet"
  sub_configs = {
    name      = "sub-frontend-${local.env_dev}"
    rg_name   = module.rg_dev.rg_out.name
    vnet_name = module.vnet_dev.vnet_out.name
    prefix = ["10.0.1.0/24"]
  }
}
module "sub_backend_dev" {
  source = "../../moduls/subnet"
  sub_configs = {
    name      = "sub-backend-${local.env_dev}"
    rg_name   = module.rg_dev.rg_out.name
    vnet_name = module.vnet_dev.vnet_out.name
    prefix = ["10.0.2.0/24"]
  }
}