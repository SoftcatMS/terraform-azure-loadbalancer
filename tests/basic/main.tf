resource "azurerm_resource_group" "rg-lb-test-basic" {
  name     = "rg-test-lb-basic-resources"
  location = "UK South"
}

module "vnet" {

  source              = "git@github.com:SoftcatMS/azure-terraform-vnet"
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


module "basic_public_lb" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.rg-lb-test-basic.name
  name                = "lb-basic-public-test"
  pip_name            = "pip-lb-basic-public-test"

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
