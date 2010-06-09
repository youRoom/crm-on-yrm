module CustomersHelper

  def entry_url(entry, group)
    "#{Customer.base_url(u(group))}/entries/#{entry['id']}"
  end
end
