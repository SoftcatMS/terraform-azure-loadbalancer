# copyright: 2018, The Authors

# Test values

resource_group1 = 'rg-test-lb-advanced-resources'



describe azure_load_balancer(resource_group: resource_group1, name: 'lb-advanced-public-test') do
  it { should exist }
end



describe azure_load_balancer(resource_group: resource_group1, name: 'lb-advanced-private-test') do
  it { should exist }
end
