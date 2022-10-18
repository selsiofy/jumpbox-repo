module "bastion_host" {
  source               = "./.."
  rg_name  = "bastion"
  rg_location          = "East US"
  azure_bastion_subnet = module.bastion_host.azure_bastion_subnet

  public_ip_id         = module.bastion_host.public_ip_id
  azure_bastion_vn     = "bastion-virtual-network"
}
