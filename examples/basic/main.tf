resource "azurerm_resource_group" "example" {
  name     = "rg-example-resources"
  location = "UK South"
}

module "vnet" {

  source              = "github.com/SoftcatMS/azure-terraform-vnet"
  vnet_name           = "vnet-lb-example-basic"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.2.0.0/16"]
  subnet_prefixes     = ["10.2.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.example]
}


module "basic_public_lb" {
  source              = "github.com/SoftcatMS/azure-terraform-loadbalancer"
  resource_group_name = azurerm_resource_group.example.name
  name                = "lb-basic-public-example"
  pip_name            = "pip-lb-basic-public-example"

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
