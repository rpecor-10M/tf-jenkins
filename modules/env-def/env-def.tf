module "main-resource-group" {
  source                    = "../resource-group"
  prefix                    = "${var.prefix}"
  env                       = "${var.env}"
  location                  = "${var.location}"
  rg_name                   = "main"
}
# module "main-network" {
#   source                    = "../network"
#   prefix                    = "${var.prefix}"
#   env                       = "${var.env}"
#   location                  = "${var.location}"
#   rg_name                   = "${module.main-resource-group.resource_group_name}"
#   network_name              = "net1"
#   subnet_name               = "sub1"
# }

# ACR registry configuration.
module "acr" {
  source          = "../acr"
  prefix          = "${var.prefix}"
  env             = "${var.env}"
  location        = "${var.location}"
  rg_name         = "${module.main-resource-group.resource_group_name}"
  acr_name        = "acrdev"
  acr_sku         = "standard"
  ext_service_principal_id = "${module.aks.aks_service_principal_id}"
}

# AKS configuration.
module "aks" {
  source          = "../kube"
  prefix          = "${var.prefix}"
  env             = "${var.env}"
  location        = "${var.location}"
  rg_name         = "${module.main-resource-group.resource_group_name}"
  cluster_name    = "aks-demo"
  dns_prefix      = "aksdemo"
  agent_count     = "2"
  agent_pool_name = "akspool"
  vm_size         = "Standard_B2s"
  os_disk_size_gb = "30"
}


