resource "azurerm_resource_group" "example" {
  name     = "rg-example-resources"
  location = "UK South"
}

module "vnet" {

  source              = "github.com/SoftcatMS/azure-terraform-vnet"
  vnet_name           = "vnet-lb-example-advanced"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.3.0.0/16"]
  subnet_prefixes     = ["10.3.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.example]
}


module "advanced_public_lb" {
  source              = "Azure/loadbalancer/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  name                = "lb-advanced-public-example"
  pip_name            = "pip-lb-advanced-public-example"

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }

  lb_probe = {
    http = ["Tcp", "80", ""]
  }


  depends_on = [azurerm_resource_group.example]
}


module "advanced_private_lb" {
  source                                 = "Azure/loadbalancer/azurerm"
  resource_group_name                    = azurerm_resource_group.example.name
  name                                   = "lb-advanced-private-example"
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
    environment = "example"
    engineer    = "ci/cd"
  }

  depends_on = [azurerm_resource_group.example]
}
