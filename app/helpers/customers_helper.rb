module CustomersHelper

  def entry_url(entry_id, group)
    "#{Customer.base_url(u(group))}/entries/#{entry_id}"
  end
end
