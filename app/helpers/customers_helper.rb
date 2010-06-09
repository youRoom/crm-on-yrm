module CustomersHelper

  def entry_url(customer, group)
    "#{Customer.base_url(u(group))}/entries/#{customer.id}"
  end
end
