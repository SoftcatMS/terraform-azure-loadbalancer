resource "azurerm_resource_group" "rg-lb-test-basic" {
  name     = "rg-test-lb-basic-resources"
  location = "UK South"
}

module "vnet" {

  source              = "github.com/SoftcatMS/azure-terraform-vnet"
  vnet_name           = "vnet-lb-test-basic"
  resource_group_name = azurerm_resource_group.rg-lb-test-basic.name
  address_space       = ["10.2.0.0/16"]
  subnet_prefixes     = ["10.2.1.0/24"]
  subnet_names        = ["subnet1"]

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }

  depends_on = [azurerm_resource_group.rg-lb-test-basic]
}

resource "azurerm_public_ip" "pip-lb-test-basic" {
  name                = "pip-lb-test-basic"
  resource_group_name = azurerm_resource_group.rg-lb-test-basic.name
  location            = azurerm_resource_group.rg-lb-test-basic.location
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Standard"
  sku_tier            = "Regional"

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }

  depends_on = [azurerm_resource_group.rg-lb-test-basic]
}


module "basic_public_lb" {
  source                = "../../"
  resource_group_name   = azurerm_resource_group.rg-lb-test-basic.name
  name                  = "lb-basic-public-test"
  lb_sku                = "Standard"
  frontend_name         = "lb-basic-public-test-ip"
  pip_name              = azurerm_public_ip.pip-lb-test-basic.name

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

  depends_on = [azurerm_resource_group.rg-lb-test-basic]
}
