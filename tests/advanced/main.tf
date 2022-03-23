resource "azurerm_resource_group" "rg-lb-test-advanced" {
  name     = "rg-test-lb-advanced-resources"
  location = "UK South"
}

module "vnet" {

  source              = "github.com/SoftcatMS/azure-terraform-vnet"
  vnet_name           = "vnet-lb-test-advanced"
  resource_group_name = azurerm_resource_group.rg-lb-test-advanced.name
  address_space       = ["10.3.0.0/16"]
  subnet_prefixes     = ["10.3.1.0/24"]
  subnet_names        = ["subnet1"]

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }

  depends_on = [azurerm_resource_group.rg-lb-test-advanced]
}


module "advanced_public_lb" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.rg-lb-test-advanced.name
  name                = "lb-advanced-public-test"
  pip_name            = "pip-lb-advanced-public-test"

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }

  lb_probe = {
    http = ["Tcp", "80", ""]
  }

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }

  depends_on = [azurerm_resource_group.rg-lb-test-advanced]
}


module "advanced_private_lb" {
  source                                 = "../../"
  resource_group_name                    = azurerm_resource_group.rg-lb-test-advanced.name
  name                                   = "lb-advanced-private-test"
  type                                   = "private"
  frontend_subnet_id                     = module.vnet.vnet_subnets[0]
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = "10.3.1.6"
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard" #`pip_sku` must match `lb_sku` 

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http  = ["80", "Tcp", "80"]
    https = ["443", "Tcp", "443"]
  }

  lb_probe = {
    http  = ["Tcp", "80", ""]
    http2 = ["Http", "1443", "/"]
  }

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }

  depends_on = [azurerm_resource_group.rg-lb-test-advanced]
}
