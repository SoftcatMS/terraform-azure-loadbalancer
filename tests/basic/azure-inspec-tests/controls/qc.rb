# copyright: 2018, The Authors

# Test values

resource_group1 = 'rg-test-lb-basic-resources'



describe azure_load_balancer(resource_group: resource_group1, name: 'lb-basic-public-test') do
  it { should exist }
end
